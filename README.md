![identified](identified_logo.png)

**identified** is a gem to help validate government document identifiers (such as Social Security Numbers) and extract any other useful data.

Currently the gem only supports Social Security Numbers, but will be expanded to support other documents in the future.

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

`Identified::SSN` cannot completely verify an SSN but it can help you rule out whether it's potentially invalid if it was issued before [SSN Randomization](http://www.ssa.gov/employer/randomization.html) came into effect.

Creating a new SSN to validate:

```ruby
ssn = Identified::SSN.new('123-45-6789')
# OR
ssn = Identified::SSN.new('123456789') # Note: ssn.to_s will still return '123-45-6789'
```

This gem also checks if each field value is within range. This is the only information that can be validated algorithmically if the SSN was issued after SSN randomization.

```ruby
ssn.valid? # => true
```

It is also possible to check against the SSN high group lists to eliminate millions of potentially invalid numbers. This requires knowing the issuance date of the SSN. If the provided date is after the randomization date, the behavior of `valid?` will be as if you did not provide an issuance date argument. The date must be in `yyyy-mm-dd` format.

```ruby
ssn.valid?('1985-10-26') # => false
```

You can also often find out which state / province issued the SSN as long as the issuance date is prior to SSN randomization. The date must be in `yyyy-mm-dd` format.

```ruby
ssn.issuing_areas('1985-10-26') # => ['NY']
```

Additionally, you can access each component field of the SSN as follows:

```ruby
ssn.area # => 123
ssn.group # => 45
ssn.serial # => 6789
```

## License

**identified** is released under the MIT license. See `LICENSE` for details.
