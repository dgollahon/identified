module Identified
  class AreaNumber
    attr_reader :value

    def initialize(number)
      @value = number
    end

    def valid?(date_issued: nil)
      # When no date is provided, we assume the date issued is post randomization.
      if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE
        # Currently only 000, 666 & 900+ are prohibited area numbers. See http://www.ssa.gov/employer/randomization.html
        (1..665).include?(value) || (667..899).include?(value)
      else
        # Prior to June 25, 2011 areas of 734-749 and above 772 were not used. Additionally, 000 and 666 are prohibited.
        # See https://en.wikipedia.org/wiki/Social_Security_number#Valid_SSNs
        # The source for the wikipedia article is http://www.socialsecurity.gov/employer/stateweb.htm, but it seems that
        # the table presented is slightly out of date because it shows 750-772 as not issued when they really were.
        # This can be (was) validated by checking the claim against the high group lists and seeing which had been used.
        (1..665).include?(value) || (667..733).include?(value) || (750..772).include?(value)
      end
    end

    def issuing_areas(date_issued)
      self.class.issuing_areas(date_issued, @value)
    end

  private

  def self.issuing_areas(date_issued, area_number)
    return [] if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE

    @issuing_areas_table ||= load_issuing_areas_table
    areas = @issuing_areas_table[area_number]

    areas ? areas : []
  end

  def self.load_issuing_areas_table
    raw_data_file = File.open('data/ssn/area_data.txt', 'r')
    raw_data = raw_data_file.read

    issuing_areas_table = parse_issuing_areas(raw_data)

    raw_data_file.close

    issuing_areas_table
  end

  def self.parse_issuing_areas(raw_data)
    lookup_table = {}

    raw_data.scan(/(\d{3})-(\d{3})\s(\w{2})/).each do |match|
      start_range, end_range, area_id = extract_issuing_area_components(match)
      (start_range..end_range).each do |area_number|
        lookup_table[area_number] ||= []
        lookup_table[area_number] << area_id
      end
    end

    lookup_table
  end

  def self.extract_issuing_area_components(match)
    start_range = match[0].to_i
    end_range = match[1].to_i
    area = match[2]

    [start_range, end_range, area]
  end

  end
end
