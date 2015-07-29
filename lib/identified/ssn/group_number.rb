module Identified
  # Represents the group number of an SSN and performs group number validation.
  class GroupNumber < DelegateClass(Fixnum)
    # Returns whether the ssn COULD be a valid ssn group code.
    def valid?(area = nil, date_issued = nil)
      # When no date is provided, we assume the date issued is post randomization.
      if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE
        (1..99).include?(self)
      else
        (1..99).include?(self) && valid_high_group?(area, date_issued)
      end
    end

    private

    # Helper function to determine if the group number was valid in a given area on a given date.
    def valid_high_group?(area, date_issued)
      high_group_list = HighGroupData.latest_applicable_list(date_issued)
      high_group = high_group_list.high_group(area)

      # If no groups have been issued yet for this area, the group is not valid.
      return false unless high_group

      SequentialGroupNumber.new(self) <= SequentialGroupNumber.new(high_group)
    end
  end
end
