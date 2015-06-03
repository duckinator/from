# From

A Ruby-equivalent to Python's `from X import Y`. The primary benefit is it avoids polluting the namespace with (e.g.) `VERSION`, as can happen when using `include`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'from'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install from

## Usage

```ruby
from('net/socket').import(:TCP, :UDP)

TCP == Net::Socket::TCP #=> true
UDP == Net::Socket::UDP #=> true
```

## Limitations

Since `require`s are unscoped, this means it exposes the toplevel constant in a required file — as well as anything exposed by its dependencies. E.g., `from('net/socket').import(:TCP)` exposes `Net::Socket`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/from/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
