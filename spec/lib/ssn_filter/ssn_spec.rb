require 'spec_helper'

describe SSN do
  context 'when creating an ssn' do
    it 'should accept valid dashed format' do
      ssn = SSN.new('123-45-6789')

      expect(ssn.area).to eq 123
      expect(ssn.group).to eq 45
      expect(ssn.serial).to eq 6789
    end

    it 'should accept valid 9 digit format' do
      ssn = SSN.new('123456789')

      expect(ssn.area).to eq 123
      expect(ssn.group).to eq 45
      expect(ssn.serial).to eq 6789
    end

    it 'should not accept fewer digits' do
      expect { SSN.new('12345678') }.to raise_error StandardError
    end

    it 'should not accept more digits' do
      expect { SSN.new('1234567890') }.to raise_error StandardError
    end

    it 'should not accept a malformed area' do
      expect { SSN.new('12345-10-2134') }.to raise_error StandardError
    end

    it 'should not accept a malformed group' do
      expect { SSN.new('1234-0-2134') }.to raise_error StandardError
    end

    it 'should not accept a malformed serial' do
      expect { SSN.new('123-45-1') }.to raise_error StandardError
    end

    it 'should not accept an integer' do
      expect { SSN.new(123456789) }.to raise_error StandardError
    end
  end
end
