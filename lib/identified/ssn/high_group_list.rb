module Identified
  # An in-memory representation of a textual high group list.
  class HighGroupList
    attr_reader :date_effective, :high_groups

    def initialize(filename)
      raw_data_file = File.open(filename, 'r')
      raw_data = raw_data_file.read

      @date_effective = parse_date(raw_data)
      @high_groups = parse_high_groups(raw_data)

      raw_data_file.close
    end

    def high_group(area)
      high_groups[area]
    end

    # Searches the raw for the effective date.
    def parse_date(raw_data)
      raw_date = raw_data.match(%r(HIGHEST GROUP ISSUED AS OF (\d+/\d{2}/\d{2})))[1]

      day, month, year = extract_date_elements(raw_date)

      Date.new(year, month, day)
    end

    # Helper function to extract the integer components from the raw date string.
    def extract_date_elements(date_string)
      date_parts = date_string.split('/')

      year = date_parts[2].to_i + 2000
      month = date_parts[0].to_i
      day = date_parts[1].to_i

      [day, month, year]
    end

    # Loads high groups into a hash table that is indexed by area.
    def parse_high_groups(raw_data)
      lookup_table = {}

      raw_data.scan(/(\d{3})\s+(\d{2})/).each do |match|
        area, group = extract_high_group_elements(match)
        lookup_table[area] = group
      end

      lookup_table
    end

    # Provides the integer versions of the high group data in for easy mass-assignment.
    def extract_high_group_elements(high_group_tuple)
      high_group_tuple.map(&:to_i)
    end
  end
end
