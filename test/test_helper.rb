require "simplecov"
SimpleCov.start

require "bundler/setup"
require "normalize_attributes"

require "minitest/utils"
require "minitest/autorun"

ActiveRecord::Base.belongs_to_required_by_default = true
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

# Load database schema
load "schema.rb"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }
