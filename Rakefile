require "rake"
require "rspec/core/rake_task"
require "./lib/normalize_attributes/version"

desc "Default: run specs."
task :default => :spec

desc "Run the specs"
RSpec::Core::RakeTask.new do |t|
  t.ruby_opts = %w[-Ilib -Ispec]
end

begin
  require "jeweler"

  JEWEL = Jeweler::Tasks.new do |gem|
    gem.name = "normalize_attributes"
    gem.version = NormalizeAttributes::Version::STRING
    gem.summary = "Normalize ActiveRecord attributes"
    gem.description = "Normalize ActiveRecord attributes"
    gem.authors = ["Nando Vieira"]
    gem.email = "fnando.vieira@gmail.com"
    gem.homepage = "http://github.com/fnando/normalize_attributes"
    gem.has_rdoc = false
    gem.add_dependency "activerecord"
    gem.files = FileList["{Gemfile,Gemfile.lock,Rakefile,MIT-LICENSE,normalize_attributes.gemspec,README.rdoc}", "{lib,spec,templates}/**/*"]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError => e
  puts "You don't Jeweler installed, so you won't be able to build gems."
end
