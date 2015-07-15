module SSNFilter
  class HighGroupData
    def self.all
      @high_group_lists ||= load_data
    end

    def self.latest_applicable_list(date_issued)
      latest_applicable_list = nil

      @high_group_lists.each do |high_group_list|
        return latest_applicable_list if date_issued > high_group_list.date_effective
        latest_applicable_list = high_group_list
      end
    end

    def self.load_data
      Dir['data/*.txt'].map { |filename| HighGroupList.new(filename) }
    end
  end
end
