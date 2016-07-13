ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'capybara/rails'
require 'capybara/rspec/matchers'
require 'minitest/rails/capybara'
require 'factory_girl_rails'
require 'minitest/byebug' if ENV['DEBUG']
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
=begin    
  fixtures :roles
  fixtures :users
  fixtures :countries
=end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
