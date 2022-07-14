# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_reader :validates

    def validate(attr_name, type, arguments = {})
      @validates ||= []
      @validates << { attr_name: attr_name, type: type, arguments: arguments }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |validation|
        attr_name = instance_variable_get("@#{validation[:attr_name]}")
        send("valid_#{validation[:type]}", attr_name, *validation[:arguments])
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def valid_presence(attr_name)
      raise 'Значение атрибута не может являться nil или пустой строкой!' if attr_name.nil? || attr_name.empty?
    end

    def valid_format(attr_name, format)
      raise 'Значения атрибута не соответствует заданному регулярному выражению!' if attr_name !~ format
    end

    def valid_type(attr_name, class_type)
      raise 'Значения атрибута не соответствует заданному классу!' unless attr_name.class.is_a? class_type
    end
  end
end
