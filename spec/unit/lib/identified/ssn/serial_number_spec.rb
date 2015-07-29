require 'spec_helper'

module Identified
  describe SerialNumber do
    context 'area validation' do
      it 'should not accept 0 as a serial' do
        expect(SerialNumber.new(0).valid?).to be false
      end

      it 'should accept 1-9999 as a serial' do
        (1..9999).each do |serial_number|
          expect(SerialNumber.new(serial_number).valid?).to be true
        end
      end

      it 'should not accept 10k+ as a serial' do
        expect(SerialNumber.new(10_000).valid?).to be false
      end
    end
  end
end
