# BG::Common

A Ruby library of common behaviors, especially for Ruby on Rails applications.

# Table of Contents

<!-- MarkdownTOC depth=4 autolink=true bracket=round -->

- Installation
- Usage
  - I. Basic Auth
- Development
- Contributing

<!-- /MarkdownTOC -->

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bg-common'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bg-common

## Usage

### I. Basic Auth

To hide an app from bots and people who are trying to troll us, we want to hide the app behind a "firewall". Typically we want to do that for staging or any other environment that is not public.

The best way to do that is to put the app behind Basic Auth.

To enable Basic Auth, add the following as an ENV variable:

```
BASIC_AUTH_ENABLED=true
BASIC_AUTH_USERNAME=user
BASIC_AUTH_PASSWORD=password
```

make sure to change `user` and `password` to something a bit more secure!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bearandgiraffe/bg-common. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

