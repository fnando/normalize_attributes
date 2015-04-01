module NormalizeAttributes
  module ActiveRecord
    def self.included(base)
      base.instance_eval do
        extend ClassMethods
        include InstanceMethods
        before_validation :normalize_attributes

        class << self
          attr_accessor :normalize_options
        end
      end
    end

    module ClassMethods
      def normalize(*args, &block)
        self.normalize_options ||= {}
        options = args.extract_options!

        args.each do |attr_name|
          attr_name = attr_name.to_sym

          normalize_options.tap do |o|
            o[attr_name] ||= []
            o[attr_name] << [[block, options[:with]].flatten.compact, options.except(:with)]
          end
        end
      end

      alias_method :normalize_attributes, :normalize
      alias_method :normalize_attribute, :normalize
      alias_method :normalize_attr, :normalize
      alias_method :normalize_attrs, :normalize
    end

    module InstanceMethods
      private
      def normalize_attributes
        return unless self.class.normalize_options

        self.class.normalize_options.each do |name, items|
          items.each do |item|
            apply_normalizers name, *item.dup
          end
        end
      end

      def apply_normalizers(name, normalizers, options)
        if options[:raw] && respond_to?("#{name}_before_type_cast")
          value = send("#{name}_before_type_cast")
        else
          value = send(name)
        end

        if normalizers.empty?
          case value
          when String
            normalizers << :squish
          when Array
            normalizers << :compact
          end
        end

        normalizers.each do |normalizer|
          if normalizer.respond_to?(:call)
            value = normalizer.call(value)
          elsif value.respond_to?(normalizer)
            value = value.send(normalizer)
          elsif respond_to?(normalizer)
            value = send(normalizer, value)
          end
        end

        begin
          write_attribute name, value
        rescue ActiveModel::MissingAttributeError
          send :"#{name}=", value
        end
      end
    end
  end
end
