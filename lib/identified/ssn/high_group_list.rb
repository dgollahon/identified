module Identified
  # An in-memory representation of a textual high group list.
  class HighGroupList
    attr_reader :date_effective, :high_groups

    def initialize(filename)
      raw_data = File.read(filename)

      @date_effective = parse_date(raw_data)
      @high_groups = parse_high_groups(raw_data)
    end

    # The highest group that has been issued for a given area.
    def high_group(area)
      high_groups[area]
    end

    private

    # Searches the raw for the effective date.
    def parse_date(raw_data)
      raw_date = %r(HIGHEST GROUP ISSUED AS OF (?<date>\d{1,2}/\d{2}/\d{2})).match(raw_data)[:date]

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
      raw_data.scan(/(\d{3})\s+(\d{2})/).to_enum.with_object({}) do |(area, group), table|
        table[area.to_i] = group.to_i
      end
    end
  end
end
