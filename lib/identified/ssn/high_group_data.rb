module Identified
  # The module that provides access to set of all high group data available.
  module HighGroupData
    def self.all
      data
    end

    def self.latest_applicable_list(date_issued)
      # Fetch the earliest dated list that is on or later than the issuance date.
      data.detect { |list| date_issued <= list.date_effective }
    end

    def self.data
      @data ||= load_data
    end
    private_class_method :data

    # Loads all high group lists into memory. The data is sorted in increasing order by the date the
    # high group list was effective on.
    def self.load_data
      Dir['data/ssn/high_groups/*.txt']
        .map { |filename| HighGroupList.new(filename) }
        .sort_by!(&:date_effective)
    end
    private_class_method :load_data
  end
end
