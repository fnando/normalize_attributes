# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :tokens
  serialize :preferences

  attr_accessor :nickname

  def normalize_username(username)
    username.downcase
  end

  private def private_normalize_username(username)
    username.upcase
  end
end
