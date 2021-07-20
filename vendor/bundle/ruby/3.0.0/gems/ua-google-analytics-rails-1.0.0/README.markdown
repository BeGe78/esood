[![Code Climate](https://codeclimate.com/github/spodlecki/ua-google-analytics-rails/badges/gpa.svg)](https://codeclimate.com/github/spodlecki/ua-google-analytics-rails)
[![Test Coverage](https://codeclimate.com/github/spodlecki/ua-google-analytics-rails/badges/coverage.svg)](https://codeclimate.com/github/spodlecki/ua-google-analytics-rails/coverage)
[![Build Status](https://travis-ci.org/spodlecki/ua-google-analytics-rails.svg)](https://travis-ci.org/spodlecki/ua-google-analytics-rails)


Fast Google Analytics setup for Rails using Universal Analytics code. This gem is mostly intended for small to medium websites with a simple analytics strategy.

**Note:**

Original [Google Analytics Rails Project](https://github.com/bgarret/google-analytics-rails) has been MIA to update to Universal Analytics. The project is essentially a direct port from the old repo.


Installation
============

Add the following to your `Gemfile`:

    gem 'ua-google-analytics-rails'

Then run:

    bundle install

Upgrade Notes
============

__Upgrading this gem from 0.0.6?__

Use `analytics_init` to send submissions to Analytics if you are using multiple trackers. You can supply a name to tracker by passing `:name` option.

**GoogleAnalytics::Events::SetAllowLinker** is no longer supported as an external variable being set. You can submit as normal in the `:add_events` array, but using the new `:setup` config is preferable so no extra array searching has to happen.

**GoogleAnalytics::Events::SetCustomVar** is no longer supported by Universal Analytics. These have been changed to SetCustomDimension & SetCustomMetric. By default if you use SetCustomVar, it applies as a Dimension

**GoogleAnalytics::Events::DeleteCustomVar** has been removed

**Added Event Helpers**

  - GoogleAnalytics::Events::ExperimentId
  - GoogleAnalytics::Events::ExperimentVariation

**TODO:** Add Double Click Snippet Support
While the code is there, and it looks like it is simply changing the end path to the JS, this feature has not been tested.

**Ruby 1.8.7 Support** While it should work on Ruby 1.8.7. No longer running test suite for it for CodeClimate Gem Requirements.


Documentation
=============

Example configurations
======================

Production only
---------------

`config/environments/production.rb`:

    # replace this with your tracker code
    GA.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if Rails.env.production? %>

With DoubleClick instead of vanilla Google Analytics script
-----------------------------------------------------------

`config/environments/production.rb`:

    # replace this with your tracker code
    GA.tracker = "UA-xxxxxx-x"
    GA.script_source = :doubleclick

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init if Rails.env.production? %>

Different accounts for development and production
-------------------------------------------------

`config/environments/production.rb`:

    # replace this with your production tracker code
    GA.tracker = "UA-xxxxxx-x"

`config/environments/development.rb`:

    # replace this with your development tracker code
    GA.tracker = "UA-xxxxxx-x"

`app/views/layout/application.html.erb`, in the `<head>` tag :

		<%= analytics_init :local => Rails.env.development? %>

License
=======

[ua-google-analytics-rails](https://github.com/spodlecki/ua-google-analytics-rails) is released under the MIT license:

* http://www.opensource.org/licenses/MIT

Original Repo:

[google-analytics-rails](https://github.com/bgarret/google-analytics-rails) is released under the MIT license:

* http://www.opensource.org/licenses/MIT