# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attributes)
      attributes.each do |name|
        attr_name = "@#{name}".to_sym
        attr_history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(attr_name) }

        define_method("#{name}=".to_sym) do |value|
          if instance_variable_get(attr_history).nil?
            instance_variable_set(attr_history, [])
          else
            instance_variable_get(attr_history) << instance_variable_get(attr_name)
          end
          instance_variable_set(attr_name, value)
        end

        define_method("#{name}_history") do
          instance_variable_get("@#{name}_history".to_sym)
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(name) }

      define_method("#{attr_name}=".to_sym) do |value|
        raise 'Неверный тип присваимого значения!' unless value.is_a?(attr_class)

        instance_variable_set(name, value)
      end
    end
  end
end
