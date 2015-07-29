require 'spec_helper'

module Identified
  describe AreaNumber do
    describe '#valid?' do
      context 'post randomization area validation' do
        it 'should not accept 0 as an area' do
          expect(AreaNumber.new(0).valid?).to be false
        end

        it 'should accept 1-665 as an area' do
          (1..665).each do |area_number|
            expect(AreaNumber.new(area_number).valid?).to be true
          end
        end

        it 'should not accept 666 as an area' do
          expect(AreaNumber.new(666).valid?).to be false
        end

        it 'should accept 667-899 as an area' do
          (667..899).each do |area_number|
            expect(AreaNumber.new(area_number).valid?).to be true
          end
        end

        it 'should not accept 900+ as an area' do
          (900..999).each do |area_number|
            expect(AreaNumber.new(area_number).valid?).to be false
          end
        end
      end
    end
  end
end
