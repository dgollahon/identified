require 'spec_helper'

describe SSNFilter do
  SSNS_WITH_ZEROS = %w(000-01-2345 123-00-4567 123-45-0000)
  PRE_RANDOMIZED_INVALID_AREAS = %w(734-12-3456 742-12-3456 749-12-3456 773-12-3456)
  POST_RANDOMIZED_INVALID_AREAS = %w(666-12-3456 900-12-3456)
  RETIRED_SSNS = %w(078-05-1120) # TODO: see if i can find a full listing
  INVALID_LENGTH_NUM_STRINGS = %w(12345678 1234567890)
  FIELD_TOO_SHORT = %w(12-34-5678 123-4-5678 123-45-678)
  FIELD_TOO_LONG = %w(1234-56-789 123-456-7890 123-45-67890)
  MALFORMED_SSNS = FIELD_TOO_LONG + FIELD_TOO_SHORT + INVALID_LENGTH_NUM_STRINGS
  ALWAYS_INVALID = POST_RANDOMIZED_INVALID_AREAS + SSNS_WITH_ZEROS + RETIRED_SSNS

  context 'when the date of birth is before randomization' do
    let(:date_of_birth) { '2011-06-24' }

    context "with a permanently invalid ssn" do
      it 'should be invalid' do
        ALWAYS_INVALID.each do |ssn|
          expect(SSNFilter.valid_ssn?(ssn, date_of_birth)).to eq false
        end
      end
    end

    it 'should disallow pre-2011 ssns with invalid areas' do
      PRE_RANDOMIZED_INVALID_AREAS.each do |ssn|
        expect(SSNFilter.valid_ssn?(ssn, date_of_birth)).to eq false
      end
    end

    it 'should fail with malformed ssns' do
      MALFORMED_SSNS.each do |ssn|
        expect { SSNFilter.valid_ssn?(ssn, date_of_birth) }.to raise_error RuntimeError
      end
    end
  end

  context 'when the date of birth is after randomization' do
    let(:date_of_birth) { '2011-06-25' }

    context "with a permanently invalid ssn" do
      it 'should be invalid' do
        ALWAYS_INVALID.each do |ssn|
          expect(SSNFilter.valid_ssn?(ssn, date_of_birth)).to eq false
        end
      end
    end

    it 'should fail with malformed ssns' do
      MALFORMED_SSNS.each do |ssn|
        expect { SSNFilter.valid_ssn?(ssn, date_of_birth) }.to raise_error RuntimeError
      end
    end
  end
end
