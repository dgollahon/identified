module Identified
  # Represents the area number of an SSN. 
  class AreaNumber < DelegateClass(Fixnum)
    # Returns whether the ssn COULD be a valid ssn area code.
    def valid?
      # Currently only 000, 666 & 900+ are prohibited area numbers.
      # See http://www.ssa.gov/employer/randomization.html
      (1..665).include?(self) || (667..899).include?(self)

      # NOTE: Prior to randomization, there were more restricted ranges. This is no longer checked
      # inside of AreaNumber because it is redundant due to the pre-randomization group number check
      # also validating this same information (if the area is absent in the table, it is unissued).
    end
  end
end
