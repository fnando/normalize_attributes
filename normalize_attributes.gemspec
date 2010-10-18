# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{normalize_attributes}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nando Vieira"]
  s.date = %q{2010-10-18}
  s.description = %q{Normalize ActiveRecord attributes}
  s.email = %q{fnando.vieira@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
     "Gemfile.lock",
     "README.rdoc",
     "Rakefile",
     "lib/normalize_attributes.rb",
     "lib/normalize_attributes/active_record.rb",
     "lib/normalize_attributes/version.rb",
     "normalize_attributes.gemspec",
     "spec/normalize_attributes_spec.rb",
     "spec/schema.rb",
     "spec/spec_helper.rb",
     "spec/support/token.rb",
     "spec/support/user.rb"
  ]
  s.homepage = %q{http://github.com/fnando/normalize_attributes}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Normalize ActiveRecord attributes}
  s.test_files = [
    "spec/normalize_attributes_spec.rb",
     "spec/schema.rb",
     "spec/spec_helper.rb",
     "spec/support/token.rb",
     "spec/support/user.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
  end
end

