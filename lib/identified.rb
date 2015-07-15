# This gem helps you filter out invalid ssns by matching against
# ssn patterns that are known to be impossible. It does not prove
# that an ssn is invalid--it just alerts you if it cannot possibly
# be valid.

require 'date'

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
