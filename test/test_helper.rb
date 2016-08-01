require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'
  add_filter '/doc/'
  add_filter '/coverage/'
  add_filter '/tmp/'
  add_filter '/public/'
  add_filter '/app/models/invoicing_line_item.rb'
  add_filter '/app/models/invoicing_tax_rate.rb'
  add_filter '/app/controllers/stripe_controller.rb'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'capybara/rails'
require 'capybara/email'
require 'capybara/rspec/matchers'
require 'minitest/rails/capybara'
require 'factory_girl_rails'
require 'minitest/byebug' if ENV['DEBUG']
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end
# class ActionDispatch includes Capybara::Email::DSL
class ActionDispatch::IntegrationTest
  include Capybara::Email::DSL
end
# class ActiveSupport
class ActiveSupport::TestCase
end
# class ActionController includes FactoryGirl, Devise and DatabaseCleaner helpers
class ActionController::TestCase
  include FactoryGirl::Syntax::Methods  
  include Devise::TestHelpers
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation
end
# class ActionMailer includes FactoryGirl, Devise and DatabaseCleaner helpers
class ActionMailer::TestCase
  include FactoryGirl::Syntax::Methods  
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation
end
