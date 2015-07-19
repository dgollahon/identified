module Identified
  # An alternate version of the group number indexed by the allocation sequence. 1 indicates the 1st
  # group number issued. 70 indicates the 70th group number issued, etc.
  class SequentialGroupNumber < DelegateClass(Fixnum)
    # Takes a regular group number and becomes a representation sequenced by allocation order.
    # Input values must be between 1 and 99. Output values will be between 1 and 100
    def initialize(group_number)
      sequential_group_number = self.class.convert_to_sequential_number(group_number)
      super(sequential_group_number)
    end

    # Converts a group number to the index of the sequence of its allocation. Valid return values
    # are between 1 and 100.
    def self.convert_to_sequential_number(group_number)
      @group_index_table ||= generate_index_conversion
      @group_index_table[group_number]
    end

    # Creates the conversion table that goes from regular group number to the index of allocation
    def self.generate_index_conversion
      index_table = {}

      # Build the lookup table (group number => sequence number).
      allocation_sequence.each.with_index(1) do |group_number, index|
        index_table[group_number] = index
      end

      index_table
    end
    private_class_method :generate_index_conversion

    def self.allocation_sequence
      # Group numbers are allocated in the order that follows:
      #  ODD - 01, 03, 05, 07, 09
      #  EVEN - 10 to 98
      #  EVEN - 02, 04, 06, 08
      #  ODD - 11 to 99
      # See http://www.ssa.gov/history/ssn/geocard.html for details.
      [*(1..9).step(2), *(10..98).step(2), *(2..8).step(2), *(11..99).step(2)]
    end
    private_class_method :allocation_sequence
  end
end
