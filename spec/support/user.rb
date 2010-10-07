class User < ActiveRecord::Base
  has_many :tokens
  serialize :preferences
end
