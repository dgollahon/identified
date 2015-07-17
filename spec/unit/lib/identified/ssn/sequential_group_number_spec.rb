require 'spec_helper'

module Identified
  describe SequentialGroupNumber do
    describe '.generate_index_conversion' do
      it 'should produce 99 elements' do
        expect(SequentialGroupNumber.generate_index_conversion.keys.length).to eq 99
        expect(SequentialGroupNumber.generate_index_conversion.values.length).to eq 99
      end
    end

    # Allocation order reference
    #  ODD1 - 01, 03, 05, 07, 09
    #  EVEN1 - 10 to 98
    #  EVEN2 - 02, 04, 06, 08
    #  ODD2 - 11 to 99
    context 'converting group numbers' do
      context 'should mark earlier numbers < later group numbers' do
        it '3 < 12 (odd1 < even1)' do
          expect(SequentialGroupNumber.new(GroupNumber.new(3))).to be < SequentialGroupNumber.new(GroupNumber.new(12))
        end

        it '7 < 2 (odd1 < even2)' do
          expect(SequentialGroupNumber.new(GroupNumber.new(7))).to be < SequentialGroupNumber.new(GroupNumber.new(2))
        end

        it '9 < 66 (odd1 < odd2)' do
          expect(SequentialGroupNumber.new(GroupNumber.new(9))).to be < SequentialGroupNumber.new(GroupNumber.new(66))
        end

        it '10 < 08 (even1 < even2)' do
          expect(SequentialGroupNumber.new(GroupNumber.new(10))).to be < SequentialGroupNumber.new(GroupNumber.new(8))
        end

        it '12 < 11 (even1 < odd2)' do
          expect(SequentialGroupNumber.new(GroupNumber.new(12))).to be < SequentialGroupNumber.new(GroupNumber.new(11))
        end

        it '6 < 99 (even2 < odd2)' do
          expect(SequentialGroupNumber.new(GroupNumber.new(6))).to be < SequentialGroupNumber.new(GroupNumber.new(99))
        end
      end
    end
  end
end
