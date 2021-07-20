# -*- encoding: utf-8 -*-
# stub: invoicing 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "invoicing".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Martin Kleppmann".freeze]
  s.date = "2020-01-14"
  s.description = "This is a framework for generating and displaying invoices (ideal for commercial\n Rails apps). It allows for flexible business logic; provides tools for tax\n handling, commission calculation etc. It aims to be both developer-friendly\n and accountant-friendly.\n".freeze
  s.email = ["@martinkl".freeze]
  s.homepage = "http://invoicing.codemancers.com/".freeze
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Ruby Invoicing Framework".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 3.2.13"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<uuid>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.2.13"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<uuid>.freeze, [">= 0"])
  end
end
