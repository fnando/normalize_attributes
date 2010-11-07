# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "normalize_attributes/version"

Gem::Specification.new do |s|
  s.name        = "normalize_attributes"
  s.version     = NormalizeAttributes::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/normalize_attributes"
  s.summary     = "Normalize ActiveRecord attributes"
  s.description = "Normalize ActiveRecord attributes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", ">= 3.0.0"
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "ruby-debug19"
end
