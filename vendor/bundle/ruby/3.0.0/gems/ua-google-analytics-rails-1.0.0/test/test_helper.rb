if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require "google-analytics-rails"
require "test/unit"

GA.tracker = "TEST"
