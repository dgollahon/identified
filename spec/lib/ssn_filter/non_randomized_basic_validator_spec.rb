require 'spec_helper'

describe NonRandomizedBasicValidator do
  context 'area validation' do
    it 'should accept 1-665 as an area' do
      (1..665).each do |area|
        ssn = SSN.new(sprintf('%.03d-12-3456', area))
        expect(NonRandomizedBasicValidator.new(ssn).valid?).to eq true
      end
    end

    it 'should accept 667-733 as an area' do
      (667..733).each do |area|
        ssn = SSN.new(sprintf('%.03d-12-3456', area))
        expect(NonRandomizedBasicValidator.new(ssn).valid?).to eq true
      end
    end

    it 'should not accept 734-749 as an area' do
      (734..749).each do |area|
        ssn = SSN.new("#{area}-12-3456")
        expect(NonRandomizedBasicValidator.new(ssn).valid?).to eq false
      end
    end

    it 'should accept 750..772 as an area' do
      (750..772).each do |area|
        ssn = SSN.new("#{area}-12-3456")
        expect(NonRandomizedBasicValidator.new(ssn).valid?).to eq true
      end
    end

    it 'should not accept 773+ as an area' do
      (773..999).each do |area|
        ssn = SSN.new("#{area}-12-3456")
        expect(NonRandomizedBasicValidator.new(ssn).valid?).to eq false
      end
    end
  end
end
