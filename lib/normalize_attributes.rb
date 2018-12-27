require "active_record"

ActiveSupport.on_load(:active_record) do
  require "active_support/core_ext/string/filters"
  require "normalize_attributes/version"
  require "normalize_attributes/active_record"

  ActiveRecord::Base.send :include, NormalizeAttributes::ActiveRecord
end
