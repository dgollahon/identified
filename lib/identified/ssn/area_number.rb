module Identified
  # Represents the area number of an SSN. Also performs pre or post randomization validation
  # depending on an issuance date is provided.
  class AreaNumber
    attr_reader :value

    def initialize(number)
      @value = number
    end

    # Returns whether the ssn COULD be a valid ssn area code.
    def valid?(date_issued = nil)
      # When date is not present assume post randomization
      if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE
        # Currently only 000, 666 & 900+ are prohibited area numbers.
        # See http://www.ssa.gov/employer/randomization.html
        (1..665).include?(value) || (667..899).include?(value)
      else
        # Prior to June 25, 2011 areas of 734-749 and above 772 were not used. Additionally, 000 and
        # 666 are prohibited. See https://en.wikipedia.org/wiki/Social_Security_number#Valid_SSNs
        # The source for the wiki article is http://www.socialsecurity.gov/employer/stateweb.htm,
        # but it seems that the table presented is slightly out of date because it shows 750-772 as
        # not issued when they really were. This can be (was) validated by checking the claim
        # against the high group lists and seeing which had been used.
        (1..665).include?(value) || (667..733).include?(value) || (750..772).include?(value)
      end
    end
  end
end
