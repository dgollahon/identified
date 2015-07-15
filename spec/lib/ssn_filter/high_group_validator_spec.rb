require 'spec_helper'

module SSNFilter
  describe HighGroupValidator do
    it 'works' do
      HighGroupValidator.group_valid?(1,1,Date.new(2008,1,1))
    end
  end
end
