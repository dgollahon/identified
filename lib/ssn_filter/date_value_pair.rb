module SSNFilter
  class DateValuePair
    attr_reader :date, :value

    def initialize(date, value)
      @date = date
      @value = value
    end
  end
end
