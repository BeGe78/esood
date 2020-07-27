source 'https://rubygems.org'

## Bundle edge Rails
gem 'rails' 
gem 'rails-html-sanitizer', '~> 1.0.4'
gem 'rack' 
gem 'etc', ">=1.1.0"
## Use passenger as a deployment tool
gem "passenger"
## Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.0'  ##use >= 1.3 and < 1.4. because version 1.4.0 has problems
## Use active model serializer
gem 'active_model_serializers'
## Use sass bootstrap for stylesheets
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'data-confirm-modal'
## Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
## Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
## Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-datatables-rails'
## upgrade loofah following a github security warning
gem 'loofah'
## upgrade sprockets, ffi, rubyzip following a github security warning
gem 'ffi' #, '~> 1.9.24'
gem 'rubyzip'
gem 'sprockets', '~> 3.7.2'
## upgrade activejob following a github security warning
gem 'activejob' 

## Turbolinks makes following links in your web application faster
gem 'turbolinks'
gem 'jquery-turbolinks'
## Build JSON APIs with ease.
gem 'multi_json' #, '~> 1.3.6'          #, '~> 1.13.1'
gem 'json', '~> 2.3.0'
gem 'rabl'
gem 'rabl-rails'
## rserve is used to access R statistical features
gem 'rserve-client'
gem 'rserve-simpler'
## use rest-client instead of world_bank gem which is broken
gem 'rest-client'
gem "websocket-extensions", ">= 0.1.5"


## WorlBank database API
#gem 'world_bank', git: 'https://github.com/codeforamerica/world_bank_ruby'
#gem 'world_bank', path: '/usr/share/gems/bundler/gems/world_bank_ruby-df43a80c876e'

## to pass rails variables to javascript
gem 'gon'
## for field autocompletion
gem 'rails-jquery-autocomplete'
## for google analytics
gem 'ua-google-analytics-rails'
## for user authentification and authorisation
gem 'bcrypt', platforms: :ruby
gem 'devise'
gem 'figaro'
gem 'cancancan'
## billing and invoicing
gem 'stripe'
gem 'invoicing'
gem 'prawn'
gem 'prawn-table'
## for documentation
gem 'yard', '~> 0.9.20'
## updae nokogiri for security reason
gem 'nokogiri', '~> 1.10.4'
## for code quality
group :development do
  gem 'rubocop', require: false
end
## for testing
group :test do
### Spring speeds up development by keeping your application running in the background.
  gem 'spring'
### Colorize minitest output and show failing tests instantly.
  gem 'minitest-colorize', git: 'https://github.com/ysbaddaden/minitest-colorize'
### minitest capybara factorybot are used for testing
  gem 'minitest-rails-capybara'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'simplecov'
end
