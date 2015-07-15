require 'spec_helper'

module Identified
  describe SSN do

    INVALID_LENGTH_NUM_STRINGS = %w(12345678 1234567890)
    FIELD_TOO_SHORT = %w(12-34-5678 123-4-5678 123-45-678)
    FIELD_TOO_LONG = %w(1234-56-789 123-456-7890 123-45-67890)
    INTEGER_REPRESENTATION = [123456789]
    MALFORMED_SSNS = FIELD_TOO_LONG + FIELD_TOO_SHORT + INVALID_LENGTH_NUM_STRINGS + INTEGER_REPRESENTATION

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

      it 'should fail with malformed ssns' do
        MALFORMED_SSNS.each do |ssn_string|
          expect { Identified::SSN.new(ssn_string) }.to raise_error Identified::MalformedSSNError
        end
      end
    end
  end
end
