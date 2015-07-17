module Identified
  # Represents a Social Security Number and provides validation functionality.
  class SSN
    RANDOMIZATION_DATE = Date.parse('2011-06-25').freeze
    RETIRED_SSNS = %w(078-05-1120 219-09-9999)
    SSN_REGEX = /\A\d{3}-\d{2}-\d{4}\Z/
    SSN_REGEX_WITHOUT_DASHES = /\A(?<area>\d{3})(?<group>\d{2})(?<serial>\d{4})\Z/

    attr_reader :date_issued, :area, :group, :serial

    # Date is optional but should be provided to improve validation quality.
    def initialize(ssn_string, options = {})
      area_num, group_num, serial_num = extract_ssn_values(ssn_string)

      @area = AreaNumber.new(area_num)
      @group = GroupNumber.new(group_num)
      @serial = SerialNumber.new(serial_num)

      # Emulating keyword arguments to provide ruby 1.9.3 support.
      @date_issued = options.delete(:date_issued)
      fail ArgumentError, "Unrecgonized option(s): #{options}" if options.any?
    end

    # Returns whether the ssn COULD be a valid ssn.
    def valid?
      area.valid?(date_issued) && group.valid?(area, date_issued) && serial.valid? && !retired?
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

    # Determines if the ssn is one of the handful of abused / always invalid ssns.
    def retired?
      RETIRED_SSNS.map { |ssn_string| SSN.new(ssn_string) }.any? { |ssn| ssn == self }
    end

    # Returns the integer components of a normalized ssn string for easy mass-assignment.
    def extract_ssn_values(ssn_string)
      formatted_ssn = format_ssn(ssn_string)
      formatted_ssn.split('-').map(&:to_i)
    end

    # Validates / converts an inputted ssn string to the normalized 123-45-6789 format.
    def format_ssn(ssn_string)
      if ssn_string =~ SSN_REGEX
        ssn_string
      elsif ssn_string =~ SSN_REGEX_WITHOUT_DASHES
        match = Regexp.last_match
        "#{match[:area]}-#{match[:group]}-#{match[:serial]}"
      else
        fail MalformedSSNError
      end
    end
  end
end
