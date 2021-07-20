# -*- encoding: utf-8 -*-
# stub: rserve-simpler 0.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "rserve-simpler".freeze
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Prince".freeze]
  s.date = "2012-02-04"
  s.description = "interface layered on top of rserve-client gem for interacting with R".freeze
  s.email = "jtprince@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/jtprince/rserve-simpler".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.15".freeze
  s.summary = "simple interface for interacting with R through Rserve".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rserve-client>.freeze, ["~> 0.3.0"])
    s.add_development_dependency(%q<spec-more>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0.0"])
    s.add_development_dependency(%q<jeweler>.freeze, ["~> 1.5.2"])
  else
    s.add_dependency(%q<rserve-client>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<spec-more>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 1.5.2"])
  end
end
