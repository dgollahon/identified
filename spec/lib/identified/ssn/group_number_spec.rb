require 'spec_helper'

module Identified
  describe GroupNumber do
    context 'basic group number validation' do
      it 'should not accept 0 as a group' do
        expect(GroupNumber.new(0).valid?).to eq false
      end

      it 'should accept 1-99 as a group' do
        (1..99).each do |group_number|
          expect(GroupNumber.new(group_number).valid?).to eq true
        end
      end
    end

    context 'comparison operator' do
      context 'should mark earlier numbers < later group numbers' do
        it '3 < 5' do
          expect(GroupNumber.new(1)).to be < GroupNumber.new(3)
        end
      end

      context 'should mark later numbers > earlier group numbers' do
        it '6 > 7' do
          expect(GroupNumber.new(2)).to be > GroupNumber.new(3)
        end
      end

      context 'comparison operators should work' do
        it '70 <= 70' do
          expect(GroupNumber.new(70)).to be <= GroupNumber.new(70)
        end

        it '70 >= 70' do
          expect(GroupNumber.new(70)).to be >= GroupNumber.new(70)
        end

        it '70 == 70' do
          expect(GroupNumber.new(70)).to eq GroupNumber.new(70)
        end
      end
    end

    context 'high group number validation [2005-05-02]' do
      context 'test file 1' do
        let(:date_issued) { Date.parse('2005-05-02') }
        # Selected line contents | 732 03  733 03  750 01  751 01  764 52  765 50 |
        let(:areas) { [732, 733, 750, 751, 764, 765] }
        let(:high_groups) { [3, 3, 1, 1, 52, 50] }

        context 'should allow group numbers < to the number in the list:' do
          it '| 732 03  733 03  750 01  751 01  764 52  765 50 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              1.upto(high_group - 1) do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area: area, date_issued: date_issued)).to eq true
              end
            end
          end
        end

        context 'should allow group numbers == to the number in the list' do
          it '| 732 03  733 03  750 01  751 01  764 52  765 50 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              group = GroupNumber.new(high_group)
              expect(group.valid?(area: area, date_issued: date_issued)).to eq true
            end
          end
        end

        context 'should disallow group numbers > to the number in the list' do
          it '| 732 03  733 03  750 01  751 01  764 52  765 50 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              (high_group + 1).upto(99) do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area: area, date_issued: date_issued)).to eq false
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

        context 'should allow group numbers < to the number in the list:' do
          it '| 643 15  644 15  645 15  646 06  647 04  648 48 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              1.upto(high_group - 1) do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area: area, date_issued: date_issued)).to eq true
              end
            end
          end
        end

        context 'should allow group numbers == to the number in the list' do
          it '| 643 15  644 15  645 15  646 06  647 04  648 48 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              group = GroupNumber.new(high_group)
              expect(group.valid?(area: area, date_issued: date_issued)).to eq true
            end
          end
        end

        context 'should disallow group numbers > to the number in the list' do
          it '| 643 15  644 15  645 15  646 06  647 04  648 48 |' do
            areas.each_with_index do |area, index|
              high_group = high_groups[index]
              (high_group + 1).upto(99) do |group_number|
                group = GroupNumber.new(group_number)
                expect(group.valid?(area: area, date_issued: date_issued)).to eq false
              end
            end
          end
        end
      end
    end
  end
end
