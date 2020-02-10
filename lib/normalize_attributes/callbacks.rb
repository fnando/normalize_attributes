# frozen_string_literal: true

module NormalizeAttributes
  def self.retrieve_value(record, attribute, raw)
    before_type_cast_method = "#{attribute}_before_type_cast"

    if raw && record.respond_to?(before_type_cast_method)
      record.send(before_type_cast_method)
    else
      record.send(attribute)
    end
  end

  def self.retrieve_normalizers(normalizers, value)
    return normalizers unless normalizers.empty?

    case value
    when String
      [:squish]
    when Array
      [:compact]
    else
      []
    end
  end

  def self.apply_normalizers(record, attribute, normalizers, options)
    value = NormalizeAttributes.retrieve_value(record, attribute, options[:raw])
    normalizers = NormalizeAttributes.retrieve_normalizers(normalizers, value)

    normalizers.each do |normalizer|
      if normalizer.respond_to?(:call)
        value = normalizer.call(value)
      elsif value.respond_to?(normalizer)
        value = value.send(normalizer)
      elsif record.respond_to?(normalizer)
        value = record.send(normalizer, value)
      end
    end

    begin
      record.send(:write_attribute, attribute, value)
    rescue ActiveModel::MissingAttributeError
      record.public_send("#{attribute}=", value)
    end
  end

  module Callbacks
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
            o[attr_name] << [
              [block, options[:with]].flatten.compact,
              options.except(:with)
            ]
          end
        end
      end

      alias normalize_attributes normalize
      alias normalize_attribute normalize
      alias normalize_attr normalize
      alias normalize_attrs normalize
    end

    module InstanceMethods
      private def normalize_attributes
        return unless self.class.normalize_options

        self.class.normalize_options.each do |attribute, items|
          items.each do |item|
            NormalizeAttributes.apply_normalizers(self, attribute, *item.dup)
          end
        end
      end
    end
  end
end
