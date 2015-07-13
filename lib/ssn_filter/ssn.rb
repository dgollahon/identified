class SSN
  attr_reader :area, :group, :serial

  def initialize(ssn_string)
    formatted_ssn = format_ssn(ssn_string)

    ssn_parts = formatted_ssn.split('-').map(&:to_i)

    @area = ssn_parts[0]
    @group = ssn_parts[1]
    @serial = ssn_parts[2]
  end

  def to_s
    sprintf('%.03d-%.02d-%.04d', @area, @group, @serial)
  end

  private

  def format_ssn(ssn_string)
    if ssn_string =~ /\A\d{3}-\d{2}-\d{4}\Z/
      ssn_string
    elsif ssn_string =~ /\A\d{9}\Z/
      "#{ssn_string[0..2]}-#{ssn_string[3..4]}-#{ssn_string[5..8]}"
    else
      fail 'Invalid ssn format.'
    end
  end
end
