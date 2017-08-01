# BG::Common

A Ruby library of common behaviors, especially for Ruby on Rails applications.

# Table of Contents

<!-- MarkdownTOC depth=4 autolink=true bracket=round -->

- [Installation](#installation)
- [Usage](#usage)
  - [I. Basic Auth](#i-basic-auth)
  - [II. Analytics](#ii-analytics)
    - [Google Analytics](#google-analytics)
    - [Intercom](#intercom)
    - [Keen.io](#keenio)
- [Development](#development)
- [Contributing](#contributing)

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

### II. Analytics

This library provides a common interface for sending events to different analytics/user tracking platforms (eg. Google Analytics, Intercom, Keen.io).

**Caveat:** Although the interface is the same, the data sent to each one is different. Some accept custom attributes, and others don't. So for that reason, you will still need to have knowledge of what each platform accepts as params. Those are explained below for each one of them.

To track an event on all of the supported platforms, all you need to do is call the `Tracker` class, with the proper params.

```ruby
require 'bg/common/analytics'

user = current_user # or whatever the logged in user object is in your case.

# Track on the various analytics tools:
tracker_data = {
  ga: {
    category: 'Users',
    action:   'User Logged In',
    label:    user.email,
    value:    nil,
    bounce:   false,
  },
  intercom: {
    event_name: 'user-logged-in',
    created_at: Time.now.to_i,
    email:      user.email,
  },
  keen: {
    event: 'user_logged_in',
    data:  {
      user_id: user.id,
      email:   user.email,
      date:    Time.now.utc.to_i, # Cannot be a time object, so cast as
                                  # Integer or String because of the following:
                                  # ActiveJob::SerializationError
                                  # (Unsupported argument type: Time)
    }
  }
}

BG::Common::Analytics::Tracker.new.call(tracker_data)
```

The call above detects whether you have background jobs enabled by checking if the `ActiveJob::Base` class is defined. If it is, it will execute the calls to each platform by creating a background job for each one. This is beneficial to make sure that these non critical third party calls do not block the user action.

If `ActiveJob::Base` is not defined, the calls would be perform inline.

**What if I do not want Google to creep on my users???**

Well that's easy, do not enable it. For each supported platform, the gem determines if it's enabled by checking on a couple of things (see the sections below for more detail) and if the checks pass, then that platform is included in the tracker call. Otherwise, that platform is ignored.

**Oh boy! That's a long namespace!**

`BG::Common::Analytics::Tracker` is a lot to type, but we expect that you will setup your class that will inherit from this one, and create your own methods that determine how the data is structured for each event. Something like this:

```ruby
class MyAnalytics < BG::Common::Analytics::Tracker
  def track_login user
    tracker_data = {
      ga: {
        category: 'Users',
        action:   'User Logged In',
        label:    user.email,
        value:    nil,
        bounce:   false,
      },
      intercom: {
        event_name: 'user-logged-in',
        created_at: Time.now.to_i,
        email:      user.email,
      },
      keen: {
        event: 'user_logged_in',
        data:  {
          user_id: user.id,
          email:   user.email,
          date:    Time.now.utc.to_i,
        }
      }
    }

    call tracker_data
  end
end

MyAnalytics.new.track_login user
```

or if you want to build something more extendable:

```
# lib/my_app/analytics/base.rb
module MyApp
  module Analytics
    class Base < ::BG::Common::Analytics::Tracker
      def initialize user:, additional_data:
        super()

        @user            = user
        @additional_data = additional_data
      end

      def call
        default_keen_data = extract_default_keen_data user: @user, additional_data: @additional_data
        extra_keen_data   = extract_extra_keen_data additional_data: @additional_data

        tracker_data = {
          ga:       { ... },
          intercom: { ... },
          keen:     {
            event: event_name,
            data:  default_keen_data.merge(extra_keen_data),
          },
        }

        super tracker_data
      end

      private

      def extract_extra_keen_data additional_data:
        raise NotImplementedError
      end

      def event_name
        raise NotImplementedError
      end

      def extract_default_keen_data user:, additional_data:
        {
          user_id:    user.id,
          user_email: user.email,
          datestamp:  Time.now.utc.to_i,
        }
      end
    end
  end
end

# lib/my_app/analytics/comment.rb
module MyApp
  module Analytics
    module Comment
      class Create < Base
        private

        def extract_extra_keen_data additional_data:
          {
            comment_id: additional_data[:comment_id]
          }
        end

        def event_name
          'new_comment'
        end
      end
    end
  end
end

# in comments_controller.rb
MyApp::Analytics::Comment::Create.new(user: current_user, additional_data: {
  comment_id: @comment.id,
}).call
```

#### Google Analytics

All you need to have GA support is to add the `gabba` gem to your `Gemfile`, and the following `ENV` variables:

```ruby
# Gemfile
gem 'gabba'
```

```
# .env
GA_TRACKER_CODE=...
GA_DOMAIN=...
```

which are required to configure the GA client.

#### Intercom

All you need to have Intercom support is to include the `intercom` gem:

```ruby
# Gemfile
gem 'intercom'
```

**PS:** make sure you configure the gem in the initializer as specified by the Intercom docs.

#### Keen.io

All you need to have GA support is to add the `keen` gem to your `Gemfile`, and the following `ENV` variables:

```ruby
# Gemfile
gem 'keen'
```

```
# .env
KEEN_PROJECT_ID=...
```

which are required to configure the Keen client.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bg-common. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

