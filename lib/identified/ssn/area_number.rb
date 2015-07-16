module Identified
  # Represents the area number of an SSN. Also performs pre or post randomization validation
  # depending on an issuance date is provided.
  class AreaNumber
    attr_reader :value

    def initialize(number)
      @value = number
    end

    # Returns whether the ssn COULD be a valid ssn area code.
    # When no date is provided, we assume the date issued is post randomization.
    def valid?(date_issued: nil)
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

    # Provides an array of potential states or protectorates the ssn was issued in. Date is required
    # because this information cannot be known if it was issued after the randomizaiton date.
    # Unknown area numbers return [].
    def issuing_areas(date_issued)
      self.class.issuing_areas(date_issued, @value)
    end

    def self.issuing_areas(date_issued, area_number)
      # When the date issued is after the randomization date, we have no information about the
      # issuing area, so return [].
      return [] if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE

      @issuing_areas_table ||= load_issuing_areas_table
      areas = @issuing_areas_table[area_number]

      areas ? areas : []
    end

    # Loads the lookup table for going from area # => state / province code
    def self.load_issuing_areas_table
      # Data originally taken from http://www.socialsecurity.gov/employer/stateweb.htm. The file
      # this reads was transformed slightly from the original to make it less cumbersome to parse.
      raw_data_file = File.open('data/ssn/area_data.txt', 'r')
      raw_data = raw_data_file.read

      issuing_areas_table = parse_issuing_areas(raw_data)

      raw_data_file.close

      issuing_areas_table
    end

    # Parses the issuing areas file contents and converts the data into a lookup table.
    def self.parse_issuing_areas(raw_data)
      lookup_table = {}

      # The data is formatted as a range [start]-[end] then the two character state/province code.
      raw_data.scan(/(\d{3})-(\d{3})\s(\w{2})/).each do |match|
        start_range, end_range, area_id = extract_issuing_area_components(match)
        (start_range..end_range).each do |area_number|
          lookup_table[area_number] ||= []
          lookup_table[area_number] << area_id
        end
      end

      lookup_table
    end

    # Helper function to parse a single row.
    def self.extract_issuing_area_components(match)
      start_range = match[0].to_i
      end_range = match[1].to_i
      area = match[2]

      [start_range, end_range, area]
    end
  end
end
