module NormalizeAttributes
  module ActiveRecord
    def self.included(base)
      class << base
        attr_accessor :normalize_attributes_options
      end

      base.instance_eval do
        extend ClassMethods
        include InstanceMethods
        before_save :normalize_attributes
        self.normalize_attributes_options = {}
      end
    end

    module ClassMethods
      def normalize_attributes(*args, &block)
        options = args.extract_options!

        args.each do |attr_name|
          attr_name = attr_name.to_sym

          normalize_attributes_options.tap do |o|
            o[attr_name] ||= []
            o[attr_name] << options[:with] if options[:with]
            o[attr_name] << block if block_given?
          end
        end
      end

      alias_method :normalize, :normalize_attributes
      alias_method :normalize_attribute, :normalize_attributes
      alias_method :normalize_attr, :normalize_attributes
      alias_method :normalize_attrs, :normalize_attributes
    end

    module InstanceMethods
      private
      def normalize_attributes
        options = self.class.normalize_attributes_options || {}

        options.each do |attr_name, normalizers|
          value = self.send(attr_name)

          if normalizers.empty?
            case value
            when String
              normalizers << :squish
            when Array
              normalizers << :compact
            end
          end

          [normalizers].flatten.each do |normalizer|
            if normalizer.respond_to?(:call)
              value = normalizer.call(value)
            elsif value.respond_to?(normalizer)
              value = value.send(normalizer)
            end
          end

          write_attribute attr_name, value
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, NormalizeAttributes::ActiveRecord
