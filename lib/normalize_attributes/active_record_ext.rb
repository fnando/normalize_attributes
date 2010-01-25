class ActiveRecord::Base
  extend SimplesIdeias::NormalizeAttributes::ClassMethods
  include SimplesIdeias::NormalizeAttributes::InstanceMethods

  cattr_accessor :normalize_attributes_options

  before_save :normalize_attributes
end
