require 'spec_helper'

module Identified
  describe GroupNumber do
    context 'basic group number validation' do
      it 'should not accept 0 as a group' do
        expect(GroupNumber.new(0).valid?).to be false
        expect(GroupNumber.new(0).valid?(1, Date.new(1985,10,26))).to be false
      end

      it 'should accept 1-99 as a group' do
        (1..99).each do |group_number|
          expect(GroupNumber.new(group_number).valid?).to be true
        end
        # check upper bound before randomization
        expect(GroupNumber.new(99).valid?(223, Date.new(2011,6,24))).to be true
      end

      it 'should not accept 100+ as a group' do
        expect(GroupNumber.new(100).valid?).to be false
        expect(GroupNumber.new(100).valid?(1, Date.new(1985,10,26))).to be false
      end

      it 'should return false when the high group is not present in the list' do
        expect(GroupNumber.new(1).valid?(773, Date.new(1985,10,26))).to be false
      end
    end

    context 'high group number validation' do
      context 'method changes with randomization date' do
        it '772-11-9999 should be invalid prior to randomization' do
          expect(SSN.new('772-11-9999', date_issued: Date.parse('2011-06-24')).valid?).to be false
        end

        it '772-11-9999 should be valid after randomization' do
          expect(SSN.new('772-11-9999', date_issued: Date.parse('2011-06-25')).valid?).to be true
          expect(SSN.new('772-11-9999', date_issued: Date.parse('2011-06-26')).valid?).to be true
        end
      end

      context 'test file 1  [2005-05-02]' do
        let(:date_issued) { Date.parse('2005-05-02') }
        # Selected line contents | 732 03  733 03  750 01  751 01  764 52  765 50 |
        let(:areas) { [732, 733, 750, 751, 764, 765] }
        let(:high_groups) { [3, 3, 1, 1, 52, 50] }
        let(:high_group_sequence) { [*(1..9).step(2), *(10..98).step(2), *(2..8).step(2), *(11..99).step(2)] }

        context 'should allow group numbers < to the number in the list:' do
          it '| 732 03  733 03  750 01  751 01  764 52  765 50 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              high_group_sequence.each do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area, date_issued)).to be true
                break if high_group == group_number
              end
            end
          end
        end

        context 'should allow group numbers == to the number in the list' do
          it '| 732 03  733 03  750 01  751 01  764 52  765 50 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              group = GroupNumber.new(high_group)
              expect(group.valid?(area, date_issued)).to be true
            end
          end
        end

        context 'should disallow group numbers > to the number in the list' do
          it '| 732 03  733 03  750 01  751 01  764 52  765 50 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              split_index = high_group_sequence.find_index {|x| x == high_group}
              high_group_sequence[(split_index + 1)..-1].each do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area, date_issued)).to be false
              end
            end
          end
        end
      end

      context 'test file 2 [2008-11-03]' do
        let(:date_issued) { Date.parse('2008-11-03') }
        # Selected line contents | 643 15  644 15  645 15  646 06  647 04  648 48 |
        let(:areas) { [643, 644, 645, 646, 647, 648] }
        let(:high_groups) { [15, 15, 15, 6, 4, 48] }
        let(:high_group_sequence) { [*(1..9).step(2), *(10..98).step(2), *(2..8).step(2), *(11..99).step(2)] }

        context 'should allow group numbers < to the number in the list:' do
          it '| 643 15  644 15  645 15  646 06  647 04  648 48 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              high_group_sequence.each do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area, date_issued)).to be true
                break if high_group == group_number
              end
            end
          end
        end

        context 'should allow group numbers == to the number in the list' do
          it '| 643 15  644 15  645 15  646 06  647 04  648 48 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              group = GroupNumber.new(high_group)
              expect(group.valid?(area, date_issued)).to be true
            end
          end
        end

        context 'should disallow group numbers > to the number in the list' do
          it '| 643 15  644 15  645 15  646 06  647 04  648 48 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              split_index = high_group_sequence.find_index {|x| x == high_group}
              high_group_sequence[(split_index + 1)..-1].each do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area, date_issued)).to be false
              end
            end
          end
        end
      end
    end
  end
end
