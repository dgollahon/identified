require 'spec_helper'

module Identified
  describe AreaNumber do
    let(:pre_randomization_date) { Date.parse('2011-06-24') }
    let(:randomization_date) { Date.parse('2011-06-25') }
    let(:post_randomization_date) { Date.parse('2011-06-26') }

    describe '#valid?' do
      context 'post randomization area validation' do
        it 'should not accept 0 as an area' do
          expect(AreaNumber.new(0).valid?).to be false
          expect(AreaNumber.new(0).valid?(randomization_date)).to be false
          expect(AreaNumber.new(0).valid?(post_randomization_date)).to be false
        end

        it 'should accept 1-665 as an area' do
          (1..665).each do |area_number|
            expect(AreaNumber.new(area_number).valid?).to be true
            expect(AreaNumber.new(area_number).valid?(randomization_date)).to be true
            expect(AreaNumber.new(area_number).valid?(post_randomization_date)).to be true
          end
        end

        it 'should not accept 666 as an area' do
          expect(AreaNumber.new(666).valid?).to be false
          expect(AreaNumber.new(666).valid?(randomization_date)).to be false
          expect(AreaNumber.new(666).valid?(post_randomization_date)).to be false
        end

        it 'should accept 667-899 as an area' do
          (667..899).each do |area_number|
            expect(AreaNumber.new(area_number).valid?).to be true
            expect(AreaNumber.new(area_number).valid?(randomization_date)).to be true
            expect(AreaNumber.new(area_number).valid?(post_randomization_date)).to be true
          end
        end

        it 'should not accept 900+ as an area' do
          (900..999).each do |area_number|
            expect(AreaNumber.new(area_number).valid?).to be false
            expect(AreaNumber.new(area_number).valid?(randomization_date)).to be false
            expect(AreaNumber.new(area_number).valid?(post_randomization_date)).to be false
          end
        end
      end

      context 'pre randomization area validation' do

        it 'should not accept 0 as an area' do
          expect(AreaNumber.new(0).valid?(pre_randomization_date)).to be false
        end

        it 'should accept 1-665 as an area' do
          (1..665).each do |area_number|
            expect(AreaNumber.new(area_number).valid?(pre_randomization_date)).to be true
          end
        end

        it 'should not accept 666 as an area' do
          expect(AreaNumber.new(666).valid?(pre_randomization_date)).to be false
        end

        it 'should accept 667-733 as an area' do
          (667..733).each do |area_number|
            expect(AreaNumber.new(area_number).valid?(pre_randomization_date)).to be true
          end
        end

        it 'should not accept 734-749 as an area' do
          (734..749).each do |area_number|
            expect(AreaNumber.new(area_number).valid?(pre_randomization_date)).to be false
          end
        end

        it 'should accept 750..772 as an area' do
          (750..772).each do |area_number|
            expect(AreaNumber.new(area_number).valid?(pre_randomization_date)).to be true
          end
        end

        it 'should not accept 773+ as an area' do
          (773..999).each do |area_number|
            expect(AreaNumber.new(area_number).valid?(pre_randomization_date)).to be false
          end
        end
      end
    end
  end
end
