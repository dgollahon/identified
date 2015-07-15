module Identified
  class SSN
    RANDOMIZATION_DATE = Date.parse('2011-06-25').freeze

    def initialize(ssn_string)
      area_num, group_num, serial_num = extract_ssn_values(ssn_string)

      @area = AreaNumber.new(area_num)
      @group = GroupNumber.new(group_num)
      @serial = SerialNumber.new(serial_num)
    end

    def area
      @area.value
    end

    def group
      @group.value
    end

    def serial
      @serial.value
    end

    def valid?(date_issued: nil)
      if date_issued
        @area.valid?(date_issued: date_issued) \
        && @group.valid?(area: area, date_issued: date_issued) \
        && @serial.valid? \
        && !retired?
      else
        @area.valid? && @group.valid? && @serial.valid? && !retired?
      end
    end

    def valid_on?(date_issued_string)
      fail InvalidDateFormatError unless date_issued_string =~ /\A\d{4}-\d{2}-\d{2}\Z/

      date_issued = Date.parse(date_issued_string) # NOTE: This could potentially still fail if the digits are out of range

      if date_issued >= RANDOMIZATION_DATE
        PostRandomizationValidator.new(self).valid?
      else
        PreRandomizationValidator.new(self).valid?
      end
    end

    def retired?
      RETIRED_SSNS.any? { |ssn| ssn == self }
    end

    def ==(other)
      area == other.area && group == other.group && serial == other.serial
    end

    def to_s
      sprintf('%.03d-%.02d-%.04d', area, group, serial)
    end

    private

    def extract_ssn_values(ssn_string)
      formatted_ssn = format_ssn(ssn_string)
      formatted_ssn.split('-').map(&:to_i)
    end

    def format_ssn(ssn_string)
      if ssn_string =~ /\A\d{3}-\d{2}-\d{4}\Z/
        ssn_string
      elsif ssn_string =~ /\A\d{9}\Z/
        "#{ssn_string[0..2]}-#{ssn_string[3..4]}-#{ssn_string[5..8]}"
      else
        fail MalformedSSNError
      end
    end

    RETIRED_SSNS = %w(078-05-1120 219-09-9999).map { |ssn| SSN.new(ssn) }.freeze
  end
end
