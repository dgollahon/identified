require 'spec_helper'

describe BasicValidator do
  context 'area validation' do
    it 'should not accept 000 as an area' do
      ssn = SSN.new('000-12-3456')
      expect(BasicValidator.new(ssn).valid?).to eq false
    end

    it 'should accept 1-665 as an area' do
      (1..665).each do |area|
        ssn = SSN.new(sprintf('%.03d-12-3456', area))
        expect(BasicValidator.new(ssn).valid?).to eq true
      end
    end

    it 'should not accept 666 as an area' do
      ssn = SSN.new('666-12-3456')
      expect(BasicValidator.new(ssn).valid?).to eq false
    end

    it 'should accept 667-899 as an area' do
      (667..899).each do |area|
        ssn = SSN.new(sprintf('%.03d-12-3456', area))
        expect(BasicValidator.new(ssn).valid?).to eq true
      end
    end

    it 'should not accept 900+ as an area' do
      (900..999).each do |area|
        ssn = SSN.new("#{area}-12-3456")
        expect(BasicValidator.new(ssn).valid?).to eq false
      end
    end
  end

  context 'group validation' do
    it 'should not accept 00 as a group' do
      ssn = SSN.new('123-00-3456')
      expect(BasicValidator.new(ssn).valid?).to eq false
    end
  end

  context 'serial validation' do
    it 'should not accept 0000 as a serial' do
      ssn = SSN.new('123-45-0000')
      expect(BasicValidator.new(ssn).valid?).to eq false
    end
  end
end
