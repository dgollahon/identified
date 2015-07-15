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
          expect(GroupNumber.new(1) < GroupNumber.new(3)).to eq true
        end
      end

      context 'should mark later numbers > earlier group numbers' do
        it '6 > 7' do
          expect(GroupNumber.new(2) > GroupNumber.new(3)).to eq true
        end
      end

      context 'comparison operators should work' do
        it '70 <= 70' do
          expect(GroupNumber.new(70) <= GroupNumber.new(70)).to eq true
        end

        it '70 >= 70' do
          expect(GroupNumber.new(70) >= GroupNumber.new(70)).to eq true
        end

        it '70 == 70' do
          expect(GroupNumber.new(70) == GroupNumber.new(70)).to eq true
        end
      end
    end

    context 'high group number validation' do
      
    end
  end
end
