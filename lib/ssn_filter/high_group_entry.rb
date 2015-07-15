module SSNFilter
  class HighGroupEntry
    attr_reader :area, :high_group

    def initialize(area, high_group)
      @area = area
      @high_group = high_group
    end
  end
end
