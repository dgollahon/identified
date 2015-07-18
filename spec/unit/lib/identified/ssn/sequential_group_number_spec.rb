require 'spec_helper'

module Identified
  describe SequentialGroupNumber do
    describe '.generate_index_conversion' do
      let(:index_conversion) { SequentialGroupNumber.send(:generate_index_conversion) }

      it 'should should produce output values of 1..99' do
        expect(index_conversion.values).to eq (1..99).to_a
      end

      it 'shoudl contain the all keys of 1 through 99' do
        expect((index_conversion.keys - (1..99).to_a).empty?).to be true
      end
    end

    describe '.allocation_sequence' do
      let(:allocation_sequence) { SequentialGroupNumber.send(:allocation_sequence) }
      it 'should produce 99 elements' do
        expect(allocation_sequence.length).to eq 99
      end

      it 'should follow the pattern odd, even, even, odd' do
        expect(allocation_sequence[0..4].all? { |x| x.odd? }).to be true
        expect(allocation_sequence[5..49].all? { |x| x.even? }).to be true
        expect(allocation_sequence[50..53].all? { |x| x.even? }).to be true
        expect(allocation_sequence[54..99].all? { |x| x.odd? }).to be true
      end

      it 'should have correct subranges' do
        expect(allocation_sequence[0..4].all? { |x| (1..9).include?(x) }).to be true
        expect(allocation_sequence[5..49].all? { |x| (10..98).include?(x) }).to be true
        expect(allocation_sequence[50..53].all? { |x| (2..8).include?(x) }).to be true
        expect(allocation_sequence[54..99].all? { |x| (11..99).include?(x) }).to be true
      end
    end

    # Allocation order reference
    #  ODD1 - 01, 03, 05, 07, 09
    #  EVEN1 - 10 to 98
    #  EVEN2 - 02, 04, 06, 08
    #  ODD2 - 11 to 99
    context 'converting group numbers' do
      it 'should convert 10 to 6' do
        expect(SequentialGroupNumber.new(10)).to eq 6
      end

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
