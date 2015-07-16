module Identified
  # Represents the serial number of an SSN and performs simple validation.
  class SerialNumber
    attr_reader :value

    def initialize(number)
      @value = number
    end

    # All non-zero serial numbers are valid regardless of when the ssn was issued.
    # See http://www.ssa.gov/history/ssn/geocard.html
    def valid?
      (1..9999).include?(value)
    end
  end
end
