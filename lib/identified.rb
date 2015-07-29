require 'date'
require 'delegate'

require_relative 'identified/errors/error'
require_relative 'identified/errors/ssn/malformed_ssn_error'

require_relative 'identified/ssn/area_number'
require_relative 'identified/ssn/group_number'
require_relative 'identified/ssn/sequential_group_number'
require_relative 'identified/ssn/serial_number'
require_relative 'identified/ssn/high_group_list'
require_relative 'identified/ssn/high_group_data'
require_relative 'identified/ssn/issuing_state_data'
require_relative 'identified/ssn/ssn'

# A module for validating government document identifiers (like SSNs) with ease.
module Identified
  module Config
    def self.data_path
      File.expand_path(File.join(__FILE__, '../../data/'))
    end
  end
end
