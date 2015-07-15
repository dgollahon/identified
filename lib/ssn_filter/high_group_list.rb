module SSNFilter
  class HighGroupList
    attr_reader :date_effective

    def initialize(filename)
      raw_data_file = File.open(filename, 'r')
      raw_data = raw_data_file.read

      @date_effective = parse_date(raw_data)
      @high_groups = parse_high_groups(raw_data)

      raw_data_file.close
    end

    def all
      @high_groups
    end

    def parse_date(raw_data)
      raw_date = raw_data.match(/HIGHEST GROUP ISSUED AS OF (\d+\/\d{2}\/\d{2})/)[1]

      date_parts = raw_date.split('/')

      year = date_parts[2].to_i + 2000
      month = date_parts[0].to_i
      day = date_parts[1].to_i

      Date.new(year, month, day)
    end

    def parse_high_groups(raw_data)
      high_group_entries = []

      raw_data.scan(/(\d{3})\s+(\d{2})/).each do |match|
        high_group_entries << HighGroupEntry.new(match[0].to_i, match[1].to_i)
      end

      high_group_entries
    end
  end
end
