require 'spec_helper'

module Identified
  describe Identified do
    SSNS_WITH_ZEROS = %w(000-01-2345 123-00-4567 123-45-0000)
    PRE_RANDOMIZED_INVALID_AREAS = %w(734-12-3456 742-12-3456 749-12-3456 773-12-3456)
    POST_RANDOMIZED_INVALID_AREAS = %w(666-12-3456 900-12-3456)
    RETIRED_SSNS = %w(078-05-1120 219-09-9999)
    ALWAYS_INVALID = (POST_RANDOMIZED_INVALID_AREAS + SSNS_WITH_ZEROS + RETIRED_SSNS).map { |ssn| SSN.new(ssn) }

    context "with a permanently invalid ssn" do
      it 'should be invalid' do
        ALWAYS_INVALID.each do |ssn|
          expect(ssn.valid?).to eq false
        end
      end
    end
  end
end
