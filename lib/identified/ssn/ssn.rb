module Identified
  # Represents a Social Security Number and provides validation functionality.
  class SSN
    RANDOMIZATION_DATE = Date.parse('2011-06-25').freeze
    RETIRED_SSNS = %w(078-05-1120 219-09-9999)

    attr_reader :date_issued

    # Date is optional but should be provided to improve validation quality.
    def initialize(ssn_string, options = {})
      area_num, group_num, serial_num = extract_ssn_values(ssn_string)

      @area = AreaNumber.new(area_num)
      @group = GroupNumber.new(group_num)
      @serial = SerialNumber.new(serial_num)

      # Emulating keyword arguments to provide ruby 1.9.3 support.
      date_issued = options.delete(:date_issued)
      fail ArgumentError, "Unrecgonized option(s): #{options}" if options.any?
      @date_issued = parse_date(date_issued) if date_issued
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
    def valid?
      @area.valid?(date_issued) && @group.valid?(area, date_issued) && @serial.valid? && !retired?
    end

    # Provides an array of potential states or protectorates the ssn was issued in. This information
    # cannot be known unless an issuance date is known and it before SSN randomizaiton. If no
    # information is avaliable, issuing_states will return [].
    def issuing_states
      IssuingStateData.issuing_states(area, date_issued)
    end

    def ==(other)
      area == other.area && group == other.group && serial == other.serial
    end

    # Uses '123-45-6789' format.
    def to_s
      format('%.03d-%.02d-%.04d', area, group, serial)
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
      RETIRED_SSNS.map { |ssn_string| SSN.new(ssn_string) }.any? { |ssn| ssn == self }
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
  end
end
