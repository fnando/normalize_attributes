# frozen_string_literal: true

class Token < ActiveRecord::Base
  belongs_to :user
end
