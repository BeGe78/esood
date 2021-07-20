# -*- encoding: utf-8 -*-
# stub: rserve-client 0.3.5 ruby lib

Gem::Specification.new do |s|
  s.name = "rserve-client".freeze
  s.version = "0.3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Claudio Bustos".freeze]
  s.date = "2017-08-27"
  s.description = "Ruby client for Rserve, a Binary R server (http://www.rforge.net/Rserve/).".freeze
  s.email = ["clbustos_at_gmail_dot_com".freeze]
  s.homepage = "http://rubygems.org/gems/rserve-client".freeze
  s.licenses = ["LGPL-2.1+".freeze]
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Rserve client for ruby".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0", ">= 1.0.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0", ">= 1.0.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 0"])
  end
end
