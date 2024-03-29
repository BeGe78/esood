# -*- encoding: utf-8 -*-
# stub: rabl-rails 0.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rabl-rails".freeze
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Christopher Cocchi-Perrier".freeze]
  s.date = "2021-03-25"
  s.description = "Fast Rails 4+ templating system with JSON, XML and PList support".freeze
  s.email = ["cocchi.c@gmail.com".freeze]
  s.homepage = "https://github.com/ccocchi/rabl-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Fast Rails 4+ templating system with JSON, XML and PList support".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.2"])
    s.add_runtime_dependency(%q<railties>.freeze, [">= 4.2"])
    s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0", ">= 1.0.2"])
    s.add_development_dependency(%q<actionpack>.freeze, [">= 4.2"])
    s.add_development_dependency(%q<actionview>.freeze, [">= 4.2"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4.2"])
    s.add_dependency(%q<railties>.freeze, [">= 4.2"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0", ">= 1.0.2"])
    s.add_dependency(%q<actionpack>.freeze, [">= 4.2"])
    s.add_dependency(%q<actionview>.freeze, [">= 4.2"])
  end
end
