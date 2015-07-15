module SSNFilter
  class HighGroupData
    def self.all
      @high_group_lists ||= load_data
      @high_group_lists
    end

    def self.load_data
      data = []

      Dir.foreach('data') do |high_group_list_filename|
        next if high_group_list_filename == '.' || high_group_list_filename == '..'
        data << HighGroupList.new('data/' + high_group_list_filename)
      end

      data
    end
  end
end
