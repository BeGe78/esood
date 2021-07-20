# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google-analytics/version"

Gem::Specification.new do |s|
  s.name        = "ua-google-analytics-rails"
  s.version     = GoogleAnalytics::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Benoit Garret", "Ufuk Kayserilioglu", "Steven Podlecki"]
  s.email       = ["benoit.garret@gadz.org", "ufuk@paralaus.com", "s.podlecki@gmail.com"]
  s.homepage    = "https://github.com/spodlecki/ua-google-analytics-rails"
  s.summary     = %q{Rails helpers to manage google analytics tracking}
  s.description = %q{Google Analytics setup for Rails using Universal Analytics code}

  s.rubyforge_project = "ua-google-analytics-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
