module Identified
  class SSN
    RANDOMIZATION_DATE = Date.parse('2011-06-25').freeze

    def initialize(ssn_string)
      area_num, group_num, serial_num = extract_ssn_values(ssn_string)

      @area = AreaNumber.new(area_num)
      @group = GroupNumber.new(group_num)
      @serial = SerialNumber.new(serial_num)
    end

    # The first three digits of the ssn.
    def area
      @area.value
    end

    # The middle two digits of the ssn.
    def group
      @group.value
    end

    # The last four digits of the ssn.
    def serial
      @serial.value
    end

    # Returns whether the ssn COULD be a valid ssn.
    # When no date is provided, we assume the date issued is post randomization.
    def valid?(date_issued: nil)
      if date_issued
        date_issued = parse_date(date_issued)
        @area.valid?(date_issued: date_issued) \
        && @group.valid?(area: area, date_issued: date_issued) \
        && @serial.valid? \
        && !retired?
      else
        @area.valid? && @group.valid? && @serial.valid? && !retired?
      end
    end

    # Provides an array of potential states or protectorates the ssn was issued in. Date is required because this
    # information cannot be known if it was issued after the randomizaiton date. Unknown area numbers return [].
    def issuing_areas(date_issued:)
      date_issued = parse_date(date_issued)
      @area.issuing_areas(date_issued)
    end

    def ==(other)
      area == other.area && group == other.group && serial == other.serial
    end

    # Uses '123-45-6789' format.
    def to_s
      sprintf('%.03d-%.02d-%.04d', area, group, serial)
    end

    private

    def parse_date(date_string)
      if date_string =~ /\d{4}-\d{2}-\d{2}/
        Date.parse(date_string)
      else
        fail InvalidDateFormatError
      end
    end

    # Determines if the ssn is one of the handful of abused / always invalid ssns.
    def retired?
      RETIRED_SSNS.any? { |ssn| ssn == self }
    end

    # Returns the integer components of a normalized ssn string.
    def extract_ssn_values(ssn_string)
      formatted_ssn = format_ssn(ssn_string)
      formatted_ssn.split('-').map(&:to_i)
    end

    # Validates / converts an inputted ssn string to the normalized 123-45-6789 format.
    def format_ssn(ssn_string)
      if ssn_string =~ /\A\d{3}-\d{2}-\d{4}\Z/
        ssn_string
      elsif ssn_string =~ /\A\d{9}\Z/
        "#{ssn_string[0..2]}-#{ssn_string[3..4]}-#{ssn_string[5..8]}"
      else
        fail MalformedSSNError
      end
    end

    # Load all retired ssns at class load. Must be at end of file to use SSN.new.
    RETIRED_SSNS = %w(078-05-1120 219-09-9999).map { |ssn| SSN.new(ssn) }.freeze
  end
end
