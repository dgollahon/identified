require 'date'

require_relative 'identified/errors/error'
require_relative 'identified/errors/invalid_date_format_error'
require_relative 'identified/errors/ssn/malformed_ssn_error'

require_relative 'identified/ssn/area_number'
require_relative 'identified/ssn/group_number'
require_relative 'identified/ssn/serial_number'
require_relative 'identified/ssn/high_group_list'
require_relative 'identified/ssn/high_group_data'
require_relative 'identified/ssn/ssn'

module Identified
end
