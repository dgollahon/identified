module Identified
  # Represents the group number of an SSN and performs group number validation.
  class GroupNumber < DelegateClass(Fixnum)
    # Returns whether the ssn COULD be a valid ssn group code.
    def valid?(area = nil, date_issued = nil)
      # When no date is provided, we assume the date issued is post randomization.
      if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE
        (1..99).include?(self)
      else
        valid_high_group?(area, date_issued)
      end
    end

    private

    # Helper function to determine if thi group number was valid in a given area on a given date.
    def valid_high_group?(area, date_issued)
      high_group_list = HighGroupData.latest_applicable_list(date_issued)
      high_group = high_group_list.high_group(area)
      
      SequentialGroupNumber.new(self) <= SequentialGroupNumber.new(high_group)
    end
  end
end
