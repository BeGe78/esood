# -*- encoding: utf-8 -*-
# stub: minitest-rails 6.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "minitest-rails".freeze
  s.version = "6.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Moore".freeze]
  s.date = "2020-12-14"
  s.description = "Adds Minitest as the default testing library in Rails".freeze
  s.email = ["mike@blowmage.com".freeze]
  s.homepage = "http://blowmage.com/minitest-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Minitest integration for Rails".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<minitest>.freeze, ["~> 5.10"])
    s.add_runtime_dependency(%q<railties>.freeze, ["~> 6.1.0"])
    s.add_development_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 6.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.64.0"])
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.10"])
    s.add_dependency(%q<railties>.freeze, ["~> 6.1.0"])
    s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 6.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.64.0"])
  end
end
