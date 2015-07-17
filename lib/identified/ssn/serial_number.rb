module Identified
  # Represents the serial number of an SSN and performs simple validation.
  class SerialNumber < DelegateClass(Fixnum)
    # All non-zero serial numbers are valid regardless of when the ssn was issued.
    # See http://www.ssa.gov/history/ssn/geocard.html
    def valid?
      (1..9999).include?(self)
    end
  end
end
