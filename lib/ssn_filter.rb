# This gem helps you filter out invalid ssns by matching against
# ssn patterns that are known to be impossible. It does not prove
# that an ssn is invalid--it just alerts you if it cannot possibly
# be valid.

require 'date'

require_relative 'ssn_filter/errors/invalid_date_format_error'
require_relative 'ssn_filter/errors/malformed_ssn_error'

require_relative 'ssn_filter/area_number'
require_relative 'ssn_filter/group_number'
require_relative 'ssn_filter/serial_number'
require_relative 'ssn_filter/high_group_list'
require_relative 'ssn_filter/high_group_data'
require_relative 'ssn_filter/ssn'

module SSNFilter
end
