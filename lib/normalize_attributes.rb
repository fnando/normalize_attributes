module SimplesIdeias
  module NormalizeAttributes
    module ClassMethods
      def normalize_attributes(*args, &block)
        options = args.extract_options!

        args.each do |attr_name|
          attr_name = attr_name.to_sym

          self.normalize_attributes_options[attr_name] ||= []
          self.normalize_attributes_options[attr_name] << options[:with] if options[:with]
          self.normalize_attributes_options[attr_name] << block if block_given?
        end
      end

      alias_method :normalize_attribute, :normalize_attributes
      alias_method :normalize_attr, :normalize_attributes
      alias_method :normalize_attrs, :normalize_attributes
    end

    module InstanceMethods
      private
        def normalize_attributes
          self.class.normalize_attributes_options.each do |attr_name, methods|
            value = send(attr_name)

            [methods].flatten.each do |method|
              if method.respond_to?(:call)
                value = method.call(value)
              else
                value = value.send(method)
              end
            end

            write_attribute attr_name, value
          end
        end
    end
  end
end

# Extend ActiveRecord
require "normalize_attributes/active_record_ext"
