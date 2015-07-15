module Identified
  class HighGroupData
    def self.all
      @high_group_lists ||= load_data
    end

    def self.latest_applicable_list(date_issued)
      @high_group_lists.detect { |list| date_issued <= list.date_effective }
    end

    def self.load_data
      unordered_data = Dir['data/ssn/high_groups/*.txt'].map { |filename| HighGroupList.new(filename) }
      unordered_data.sort_by!(&:date_effective)
    end
  end
end
