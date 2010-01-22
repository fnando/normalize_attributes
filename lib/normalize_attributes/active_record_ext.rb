class ActiveRecord::Base
  cattr_accessor :normalize_attributes_options
  @@normalize_attributes_options = {}

  extend SimplesIdeias::NormalizeAttributes::ClassMethods
  include SimplesIdeias::NormalizeAttributes::InstanceMethods

  before_save :normalize_attributes
end
