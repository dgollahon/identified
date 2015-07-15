require 'spec_helper'

module SSNFilter
  describe AreaNumber do
    context 'post randomization area validation' do
      it 'should not accept 0 as an area' do
        expect(AreaNumber.new(0).valid?).to eq false
      end

      it 'should accept 1-665 as an area' do
        (1..665).each do |area_number|
          expect(AreaNumber.new(area_number).valid?).to eq true
        end
      end

      it 'should not accept 666 as an area' do
        expect(AreaNumber.new(666).valid?).to eq false
      end

      it 'should accept 667-899 as an area' do
        (667..899).each do |area_number|
          expect(AreaNumber.new(area_number).valid?).to eq true
        end
      end

      it 'should not accept 900+ as an area' do
        (900..999).each do |area_number|
          expect(AreaNumber.new(area_number).valid?).to eq false
        end
      end
    end

    context 'pre randomization area validation' do
      let(:pre_randomization_date) { Date.parse('2011-06-24') }

      it 'should not accept 0 as an area' do
        expect(AreaNumber.new(0).valid?(date_issued: pre_randomization_date)).to eq false
      end

      it 'should accept 1-665 as an area' do
        (1..665).each do |area_number|
          expect(AreaNumber.new(area_number).valid?(date_issued: pre_randomization_date)).to eq true
        end
      end

      it 'should not accept 666 as an area' do
        expect(AreaNumber.new(666).valid?(date_issued: pre_randomization_date)).to eq false
      end

      it 'should accept 667-733 as an area' do
        (667..733).each do |area_number|
          expect(AreaNumber.new(area_number).valid?(date_issued: pre_randomization_date)).to eq true
        end
      end

      it 'should not accept 734-749 as an area' do
        (734..749).each do |area_number|
          expect(AreaNumber.new(area_number).valid?(date_issued: pre_randomization_date)).to eq false
        end
      end

      it 'should accept 750..772 as an area' do
        (750..772).each do |area_number|
          expect(AreaNumber.new(area_number).valid?(date_issued: pre_randomization_date)).to eq true
        end
      end

      it 'should not accept 773+ as an area' do
        (773..999).each do |area_number|
          expect(AreaNumber.new(area_number).valid?(date_issued: pre_randomization_date)).to eq false
        end
      end
    end
  end
end
