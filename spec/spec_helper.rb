require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "rspec"
require "normalize_attributes"

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

# Load database schema
load "schema.rb"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
