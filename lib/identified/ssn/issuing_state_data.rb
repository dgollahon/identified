module Identified
  # Wraps the actual data file to provide convenient access to area number => issuing state info.
  module IssuingStateData
    # Provides an array of potential states or protectorates the ssn was issued in. Date is required
    # because this information cannot be known if it was issued after the randomizaiton date.
    # Unknown area numbers return [].
    def self.issuing_states(area_number, date_issued)
      # When the date issued is after the randomization date, we have no information about the
      # issuing area, so return [].
      return [] if !date_issued || date_issued >= SSN::RANDOMIZATION_DATE

      @issuing_areas_table ||= load_issuing_states_table

      # Return [] if the issuing areas information doesn't cover the requested area.
      @issuing_areas_table.fetch(area_number, [])
    end

    # Loads the lookup table for going from area # => state / province code
    def self.load_issuing_states_table
      # Data originally taken from http://www.socialsecurity.gov/employer/stateweb.htm. The file
      # this reads was transformed slightly from the original to make it less cumbersome to parse.
      raw_data = File.read('data/ssn/area_data.txt')

      # issuing_states_table = parse_issuing_states(raw_data)
      parse_issuing_states(raw_data)
    end

    # Parses the issuing areas file contents and converts the data into a lookup table.
    def self.parse_issuing_states(raw_data)
      lookup_table = {}

      # The data is formatted as a range [start]-[end] then the two character state / province code.
      raw_data.scan(/(\d{3})-(\d{3})\s(\w{2})/) do |match|
        start_range, end_range, area_id = extract_issuing_state_components(match)
        (start_range..end_range).each do |area_number|
          lookup_table[area_number] ||= []
          lookup_table[area_number] << area_id
        end
      end

      lookup_table
    end

    # Helper function to parse a single row.
    def self.extract_issuing_state_components(match)
      start_range = match[0].to_i
      end_range = match[1].to_i
      area = match[2]

      [start_range, end_range, area]
    end
  end
end
