require 'spec_helper'

module Identified
  describe HighGroupData do
    it 'should have 93 high group lists' do
      expect(HighGroupData.all.length).to eq 93
    end

    context '.latest_applicable_list' do
      it 'should be 2003-11-03 when the date issued is < all lists' do
        issued_date = Date.parse('1968-01-01')
        list = HighGroupData.latest_applicable_list(issued_date)
        expect(list.date_effective).to eq Date.parse('2003-11-03')
      end

      it 'should be 2003-11-03 when the date issued is also 2003-11-03' do
        date = Date.parse('2003-11-03')
        list = HighGroupData.latest_applicable_list(date)
        expect(list.date_effective).to eq date
      end

      it 'should give the second list if the date is after the first' do
        issued_date = Date.parse('2004-04-03')
        list = HighGroupData.latest_applicable_list(issued_date)
        expect(list.date_effective).to eq Date.parse('2004-05-03')
      end

      it 'should be able to retrieve the last list' do
        date = Date.parse('2011-06-24')
        list = HighGroupData.latest_applicable_list(date)
        expect(list.date_effective).to eq date
      end

      it 'should return nil if the date is after the last high group' do # REVIEW: or raise an error?
        date_issued = Date.parse('2011-06-25')
        list = HighGroupData.latest_applicable_list(date_issued)
        expect(list).to eq nil
      end
    end
  end
end
