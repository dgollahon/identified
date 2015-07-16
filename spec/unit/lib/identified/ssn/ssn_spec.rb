require 'spec_helper'

module Identified
  describe SSN do

    INVALID_LENGTH_NUM_STRINGS = %w(12345678 1234567890)
    FIELD_TOO_SHORT = %w(12-34-5678 123-4-5678 123-45-678)
    FIELD_TOO_LONG = %w(1234-56-789 123-456-7890 123-45-67890)
    INTEGER_REPRESENTATION = [123456789]
    MALFORMED_SSNS = FIELD_TOO_LONG + FIELD_TOO_SHORT + INVALID_LENGTH_NUM_STRINGS + INTEGER_REPRESENTATION

    SSNS_WITH_ZEROS = %w(000-01-2345 123-00-4567 123-45-0000)
    PRE_RANDOMIZED_INVALID_AREAS = %w(734-12-3456 742-12-3456 749-12-3456 773-12-3456)
    POST_RANDOMIZED_INVALID_AREAS = %w(666-12-3456 900-12-3456)
    RETIRED_SSNS = %w(078-05-1120 219-09-9999)
    ALWAYS_INVALID = (POST_RANDOMIZED_INVALID_AREAS + SSNS_WITH_ZEROS + RETIRED_SSNS).map { |ssn| SSN.new(ssn) }

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
          expect { Identified::SSN.new(ssn_string) }.to raise_error MalformedSSNError
        end
      end
    end

    describe '#issuing_areas' do
      context 'prior to randomization' do
        it "123-01-0001 should be ['NY']" do
          expect(SSN.new('123-01-0001', date_issued: '1968-01-01').issuing_states).to eq ['NY']
        end
      end

      context 'after randomization' do
        it "123-01-0001 should be []" do
          expect(SSN.new('123-01-0001', date_issued: SSN::RANDOMIZATION_DATE.to_s).issuing_states).to eq []
        end
      end
    end

    describe '#valid?' do
      it 'should be false with permanently invalid ssns' do
        ALWAYS_INVALID.each do |ssn|
          expect(ssn.valid?).to eq false
        end
      end
    end

    describe '#to_s' do
      it 'should output the correct format' do
        ssn = SSN.new('123456789')
        expect(ssn.to_s).to eq '123-45-6789'
      end
    end
  end
end
