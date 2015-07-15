module Identified
  class SerialNumber
    attr_reader :value

    def initialize(number)
      @value = number
    end

    def valid?
      (1..9999).include?(value)
    end
  end
end
