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

      it 'should fail with a malformed date string' do
        expect { Identified::SSN.new('123-45-6789', date_issued: '01-01-1999') }.to raise_error InvalidDateFormatError
      end

      it 'should not allow invalid options' do
        expect { Identified::SSN.new('123-45-6789', dat_issued: '1985-10-26') }.to raise_error ArgumentError, 'Unrecgonized option(s): {:dat_issued=>"1985-10-26"}'
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

      it 'should return [] when no date is provided' do
        expect(SSN.new('123-45-6789').issuing_states).to eq []
      end
    end

    describe '#valid?' do
      it 'should be false with permanently invalid ssns' do
        ALWAYS_INVALID.each do |ssn|
          expect(ssn.valid?).to be false
        end
      end

      it 'should be invalid with an invalid area before randomization' do
        expect(SSN.new('773-45-6789', date_issued: '2011-06-24').valid?).to be false
      end

      it 'should be invalid with an invalid area after randomization' do
        expect(SSN.new('000-45-6789').valid?).to be false
      end

      it 'should be invalid with an invalid group' do
        expect(SSN.new('123-00-6789').valid?).to be false
      end

      it 'should be invalid with an invalid serial' do
        expect(SSN.new('123-45-0000').valid?).to be false
      end

      context 'when on the boundary of a high group list change' do
        let(:earlier_issuance) { '2004-03-01' }
        let(:later_issuance) { '2004-03-02' }

        it 'should be invalid before the change [README example]' do
          ssn = Identified::SSN.new('012-88-9999', date_issued: earlier_issuance)
          expect(ssn.valid?).to be false
        end

        it 'should be valid after the change [README example]' do
          ssn = Identified::SSN.new('012-88-9999', date_issued: later_issuance)
          expect(ssn.valid?).to be true
        end
      end
    end

    describe '#to_s' do
      it 'should output the correct format' do
        ssn = SSN.new('123456789')
        expect(ssn.to_s).to eq '123-45-6789'
      end
    end

    describe '#==' do
      it 'should be true for equivalent ssns' do
        expect(SSN.new('123456789')).to eq SSN.new('123-45-6789')
      end

      it 'should be false for different areas' do
        expect(SSN.new('123456789')).not_to eq SSN.new('122-45-6789')
      end

      it 'should be false for different groups' do
        expect(SSN.new('123456789')).not_to eq SSN.new('123-44-6789')
      end

      it 'should be false for different serials' do
        expect(SSN.new('123456789')).not_to eq SSN.new('123-45-6780')
      end
    end

    describe '#retired?' do
      it 'should be true with retired ssns' do
        RETIRED_SSNS.map { |ssn| SSN.new(ssn) }.each do |ssn|
          expect(ssn.send(:retired?)).to be true
        end
      end

      it 'should be false with other ssns' do
        expect(SSN.new('123-45-6789').send(:retired?)).to be false
      end
    end
  end
end
