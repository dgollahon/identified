![identified](identified_logo.png)
----
[![Circle CI](https://circleci.com/gh/dgollahon/identified.svg?style=shield)](https://circleci.com/gh/dgollahon/identified)
[![Code Climate](https://codeclimate.com/github/dgollahon/identified/badges/gpa.svg)](https://codeclimate.com/github/dgollahon/identified)
[![Test Coverage](https://codeclimate.com/github/dgollahon/identified/badges/coverage.svg)](https://codeclimate.com/github/dgollahon/identified/coverage)

**identified** is a gem to help validate government document identifiers (such as Social Security Numbers) and extract any other useful data possible. This project promises to deliver high quality code that has been thoroughly tested (99%+ mutation test coverage).

Currently the gem only supports Social Security Numbers, but will be expanded to support other documents in the future.  **This method is not comprehensive and should only be used as an additional signal, not a complete solution to SSN validation.**

:boom: Battle-tested at [BlockScore](https://blockscore.com) against **~90 million** SSNs.

## Install

Simply run
```shell
gem install identified
```

or add identified to your gemfile

```ruby
gem 'identified'
```

and run `bundle install` from your shell.

## Usage

`Identified::SSN` cannot completely verify an SSN but it can help you rule out whether it's potentially invalid--especially if it was issued before [SSN Randomization](http://www.ssa.gov/employer/randomization.html) came into effect.

Creating a new SSN to validate:

```ruby
# SSN formatted With dashes.
ssn = Identified::SSN.new('123-45-6789', date_issued: Date.parse('1985-10-26'))

# SSN formatted without dashes. In either case ssn.to_s will return '123-45-6789'.
ssn = Identified::SSN.new('123456789', date_issued: Date.parse('1985-10-26'))

# If the date of issuance is unknown, it can be elided.
# This will, however, notably reduce validation quality.
ssn = Identified::SSN.new('123-45-6789')
```

This gem checks if each numeric field is within range. This is the only information that can be validated algorithmically if the date_issued is not provided or the SSN was issued after SSN randomization.

```ruby
ssn = Identified::SSN.new('123-45-6789')
ssn.valid? # => true
```

If the date of issuance is known (note that this is not necessarily the same as a date of birth), identified will check the number against the SSN high group lists and compare it to millions of invalid numbers. If the provided date is after the randomization date, the behavior of `valid?` will be as if no date of issuance was provided and only perform basic validation.

```ruby
# The earlier date causes the group number to be validated with one high group list
# whereas the later date is associated with another, newer high group list. The
# second high group list indicates that the group number is in circulation at the
# time of later date, and thus the SSN is valid.
earlier_issuance = Date.parse('2004-03-01')
later_issuance = Date.parse('2004-03-02')

ssn = Identified::SSN.new('012-88-9999', date_issued: earlier_issuance)
ssn.valid? # => false, that number could not have possibly been issued on that date.

ssn = Identified::SSN.new('012-88-9999', date_issued: later_issuance)
ssn.valid? # => true, that number is potentially valid
```

You can also often find out which state / province issued the SSN as long as the issuance date is prior to SSN randomization. If the issuing state cannot be determined (which is always true if the SSN was issued after the randomization date), an empty array will be returned.

```ruby
ssn = Identified::SSN.new('123-45-6789', date_issued: Date.parse('1985-10-26'))
ssn.issuing_states # => ['NY']
```

Additionally, you can access each component field of the SSN as follows:

```ruby
ssn = Identified::SSN.new('123-45-6789')

ssn.area # => 123
ssn.group # => 45
ssn.serial # => 6789
```

## Requirements
**identified** supports Ruby 1.9.3+

## License

**identified** is released under the MIT license. See `LICENSE` for details.
