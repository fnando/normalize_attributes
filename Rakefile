# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "appraisal"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = false
end

if !ENV["APPRAISAL_INITIALIZED"] && !ENV["TRAVIS"]
  task default: :appraisal
else
  task default: :test
end
