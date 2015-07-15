module SSNFilter
  class HighGroupValidator
    def self.group_valid?(area, group, date)
      high_group = high_group(area, date)

      fail 'Failed to lookup high group.' unless high_group

      group <= high_group
    end

    private

    def self.high_group(area, date)
      @high_group_data ||= populate_high_group_data
      area_high_groups = @high_group_data[area]

      # Start from the oldest date and return as soon as we find a date the same as or newer than the input date.
      area_high_groups.each do |dated_high_group|
        if date <= dated_high_group.date
          return dated_high_group.value
        end
      end
    end

    def self.populate_high_group_data
      data = {}

      # Load all high group data, partitioned by area
      HighGroupData.all.each do |high_group_list|
        date_effective = high_group_list.date_effective
        high_group_list.all.each do |high_group_entry|
          area = high_group_entry.area
          high_group = high_group_entry.high_group

          data[area] ||= []
          data[area] << DateValuePair.new(date_effective, high_group)
        end
      end

      # Sort the high groups by date
      data.each do |_, area_data|
        area_data.sort_by!(&:date)
      end

      data
    end
  end
end
