begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'fileutils'
require 'rake/testtask'

# Tasks to run by default
task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = false
end

Bundler::GemHelper.install_tasks
