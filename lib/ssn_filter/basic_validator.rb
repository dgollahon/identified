# Checks the few simple cases that apply to all ssns (including current).
class BasicValidator
  RETIRED_SSNS = %w(078-05-1120)

  def initialize(ssn)
    @ssn = ssn
  end

  def valid?
    area_valid? && group_valid? && serial_valid? && not_retired?
  end

  private

  # An area number may not be 000, 666, or 900+
  def area_valid?
    (1..665).include?(@ssn.area) || (667..899).include?(@ssn.area)
  end

  # Groups may not be all zeros
  def group_valid?
    @ssn.group != 0
  end

  # Serial numbers may not be all zeros
  def serial_valid?
    @ssn.serial != 0
  end

  def not_retired?
    !RETIRED_SSNS.include?(@ssn.to_s)
  end
end
