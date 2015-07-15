module Identified
  class HighGroupList
    attr_reader :date_effective

    def initialize(filename)
      raw_data_file = File.open(filename, 'r')
      raw_data = raw_data_file.read

      @date_effective = parse_date(raw_data)
      @high_groups = parse_high_groups(raw_data)

      raw_data_file.close
    end

    def high_group(area)
      @high_groups[area]
    end

    def all
      @high_groups
    end

    def parse_date(raw_data)
      raw_date = raw_data.match(/HIGHEST GROUP ISSUED AS OF (\d+\/\d{2}\/\d{2})/)[1]

      day, month, year = extract_date_elements(raw_date)

      Date.new(year, month, day)
    end

    def extract_date_elements(date_string)
      date_parts = date_string.split('/')

      year = date_parts[2].to_i + 2000
      month = date_parts[0].to_i
      day = date_parts[1].to_i

      [day, month, year]
    end

    # Loads high groups into a hash table indexed by area
    def parse_high_groups(raw_data)
      data = {}

      raw_data.scan(/(\d{3})\s+(\d{2})/).each do |match|
        area, group = extract_high_group_elements(match)
        data[area] = group
      end

      data
    end

    def extract_high_group_elements(high_group_tuple)
      high_group_tuple.map(&:to_i)
    end

  end
end
