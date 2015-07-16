module Identified
  # Raised when ssns aren't in the '123-45-6789' or '123456789' formats.
  class MalformedSSNError < Error
  end
end
