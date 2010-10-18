class User < ActiveRecord::Base
  has_many :tokens
  serialize :preferences

  def normalize_username(username)
    username.downcase
  end
end
