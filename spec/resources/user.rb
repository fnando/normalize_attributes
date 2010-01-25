class User < ActiveRecord::Base
  has_many :tokens
end
