![identified](identified_logo.png)

**identified** is a gem to help validate identifying documents (such as social security numbers) and extract any other useful data.

Currently the gem only supports social security numbers, but will be expanded to support other documents in the future.

Install
-------
Simply run
```shell
gem install identified
```
or add identified to your gemfile
```ruby
gem 'identified'
```
and run `bundle install` from your shell.

Usage
-----
`Identified::SSN` cannot completely verify an ssn but it can help you rule out whether it's invalid.

Creating a new ssn to validate:
```ruby
ssn = Identified::SSN.new('123-45-6789')
# OR
ssn = Identified::SSN.new('123456789') # Note: ssn.to_s will still return '123-45-6789'
```

Checking if each field value is within range (this is the only information that can be validated algorithmically if the ssn was issued after [SSN Randomization](http://www.ssa.gov/employer/randomization.html) became in effect).

```ruby
ssn.valid? # => true
```

Checking against the ssn high group lists to eliminate millions of potentially invalid number. Requires knowing the issuance date of the ssn. If the provided date is after the randomization date, the behavior of valid? will be as if you did not provide an issuance date argument. The date must be in yyyy-mm-dd format.
```ruby
ssn.valid?('1985-10-26') # => false
```

You can also often find out which state / province issued the ssn as long as the issuance date is prior to ssn randomization. The date must be in yyyy-mm-dd format.
```ruby
ssn.issuing_areas('1985-10-26') # => ['NY']
```

Additionally, you can access each integer field of the ssn as follows.
```ruby
ssn.area # => 123
ssn.group # => 45
ssn.serial # => 6789
```

License
-------
**identified** is released under an MIT license.
