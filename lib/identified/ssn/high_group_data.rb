module Identified
  # The module that provides access to set of all high group data available.
  module HighGroupData
    def self.all
      @high_group_lists ||= load_data
    end

    def self.latest_applicable_list(date_issued)
      @high_group_lists ||= load_data
      # Fetch the earliest date that is on or later than the issuance date.
      @high_group_lists.detect { |list| date_issued <= list.date_effective }
    end

    # Loads all high group lists into memory. The data is sorted in increasing order by the date the
    # high group list was effective on.
    def self.load_data
      Dir['data/ssn/high_groups/*.txt']
        .map { |filename| HighGroupList.new(filename) }
        .sort_by!(&:date_effective)
    end
  end
end
