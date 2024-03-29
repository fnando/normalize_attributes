# frozen_string_literal: true

require "./lib/normalize_attributes/version"

Gem::Specification.new do |s|
  s.name        = "normalize_attributes"
  s.version     = NormalizeAttributes::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/normalize_attributes"
  s.summary     = "Normalize ActiveRecord attributes"
  s.description = s.summary
  s.license     = "MIT"
  s.required_ruby_version = ">= 2.7"
  s.metadata = {"rubygems_mfa_required" => "true"}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`
                    .split("\n")
                    .map {|f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest-utils"
  s.add_development_dependency "rake"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-fnando"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
end
