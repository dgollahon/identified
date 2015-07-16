module Identified
  describe IssuingStateData do
    describe '.issuing_areas' do
      let(:pre_randomization_date) { Date.parse('2011-06-24') }

      context 'prior to randomization' do
        it "123 should be ['NY']" do
          expect(IssuingStateData.issuing_states(123, pre_randomization_date)).to eq ['NY']
        end

        it "586 should be ['GU', 'AS', 'PH']" do
          expect(IssuingStateData.issuing_states(586, pre_randomization_date)).to eq ['GU', 'AS', 'PH']
        end

        it 'unassigned ranges should return []' do
          expect(IssuingStateData.issuing_states(600, pre_randomization_date)).to eq []
        end
      end

      context 'after randomization' do
        it 'all areas should be unknown ([])' do
          (1..999).each do |area|
            expect(IssuingStateData.issuing_states(area, SSN::RANDOMIZATION_DATE)).to eq []
          end
        end
      end
    end
  end
end
