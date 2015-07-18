module Identified
  # Wraps the actual data file to provide convenient access to area number => issuing state info.
  module IssuingStateData
    ISSUING_STATE_ENTRY_REGEX = /(\d{3})-(\d{3})\s(\w{2})/
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
      raw_data.scan(ISSUING_STATE_ENTRY_REGEX) do |(start_area, end_area, state_code)|
        (start_area.to_i).upto(end_area.to_i).each do |area_number|
          lookup_table[area_number] ||= []
          lookup_table[area_number] << state_code
        end
      end

      lookup_table
    end
  end
end
