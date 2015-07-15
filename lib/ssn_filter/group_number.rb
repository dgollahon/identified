module SSNFilter
  class GroupNumber
    include Comparable

    attr_reader :value

    def initialize(number)
      @value = number
    end

    def valid?(date_issued: nil)
      # When no date is provided, we assume the date issued is post randomization.
      if !date_issued || date_issued >= SSN.RANDOMIZATION_DATE
        (1..99).include?(value)
      else
        valid_high_group(date_issued)
      end
    end

    # Compares based on order of issuance
    def <=>(other)
      sequential_value <=> other.sequential_value
    end

    # The index of the allocation sequence. 1 indicates the 1st group number issued. 70 indicates the 70th group number
    # issued, etc. Values will be between 1 and 100.
    def sequential_value
      self.class.convert_to_sequential_number(value)
    end

    private

    def valid_high_group(date_issued)
      high_group_list = HighGroupData.latest_applicable_list(date_issued)
      high_group = high_group_list.high_group(area)

      value <= high_group
    end

    # Converts a group number to the index of the sequence of its allocation. Valid return values are between 1 and 100.
    def self.convert_to_sequential_number(group_number)
      @group_index_table ||= generate_index_conversion
      @group_index_table[group_number]
    end

    # Creates the conversion table that goes from group number to the index of allocation
    def self.generate_index_conversion
      index_table = {}

      # Group numbers are allocated in the order that follows
      #  ODD - 01, 03, 05, 07, 09
      #  EVEN - 10 to 98
      #  EVEN - 02, 04, 06, 08
      #  ODD - 11 to 99
      # See http://www.ssa.gov/history/ssn/geocard.html for details
      allocation_sequence = [*1.step(9,2), *10.step(98,2), *2.step(8,2), *11.step(99,2)]

      # Build the lookup table (group number => sequence number)
      allocation_sequence.each_with_index do |group_number, index|
        index_table[group_number] = index + 1
      end

      index_table
    end
  end
end
