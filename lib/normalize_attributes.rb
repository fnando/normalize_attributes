# frozen_string_literal: true

require "active_record"

ActiveSupport.on_load(:active_record) do
  require "active_support/core_ext/string/filters"
  require "normalize_attributes/version"
  require "normalize_attributes/callbacks"

  ActiveRecord::Base.include NormalizeAttributes::Callbacks
end
