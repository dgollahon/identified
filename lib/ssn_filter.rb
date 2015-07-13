# This gem helps you filter out invalid ssns by matching against
# ssn patterns that are known to be impossible. It does not prove
# that an ssn is invalid--it just alerts you if it cannot possibly
# be valid.

require 'date'

module SSNFilter
  RANDOMIZATION_DATE = Date.parse('2011-06-25')

  def self.valid_ssn?(ssn_string, date_of_birth_string)
    ssn = SSN.new(ssn_string)

    unless date_of_birth_string =~ /\A\d{4}-\d{2}-\d{2}\Z/
      fail 'Invalid date_format'
    end

    date_of_birth = Date.parse(date_of_birth_string)

    if date_of_birth >= RANDOMIZATION_DATE
      BasicValidator.new(ssn).valid?
    else
      NonRandomizedBasicValidator.new(ssn).valid?
    end
  end
end
