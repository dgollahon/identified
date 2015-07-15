require 'spec_helper'

module SSNFilter
  describe SerialNumber do
    context 'area validation' do
      it 'should not accept 0 as a serial' do
        expect(SerialNumber.new(0).valid?).to eq false
      end

      it 'should accept 1-9999 as a serial' do
        (1..9999).each do |serial_number|
          expect(SerialNumber.new(serial_number).valid?).to eq true
        end
      end
    end
  end
end
