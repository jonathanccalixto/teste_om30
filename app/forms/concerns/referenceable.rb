# frozen_string_literal: true

module Referenceable
  extend ActiveSupport::Concern

  class_methods do
    def references(*)
      ReferenceMaker.new(self, *).make
    end
  end

  class ReferenceMaker
    def initialize(context, *references)
      @context = context
      @options = references.extract_options!
      @references = references
      @reference_ids = {}
    end

    def make
      references.each do |reference|
        field_id_name = reference_id(reference:)

        define_attribute_id_for(reference:, field_id_name:)
        define_getter_for(reference, field_id_name:, klass: model_class(reference:))
        define_setter_for(reference, field_id_name:)
      end

      nil
    end

    private

    attr_reader :context, :options, :references

    def model_class(reference:)
      (options[:class_name] || reference.to_s.camelize).constantize
    end

    def reference_id(reference:)
      @reference_ids[reference] ||= :"#{reference}_id"
    end

    def define_attribute_id_for(reference:, field_id_name:)
      before = ->(form) { form.instance_variable_set :"@#{reference}", nil }
      after = lambda { |form|
        field = form.attributes[field_id_name]
        form.attributes[field_id_name] = field.id if field.is_a? ApplicationRecord
      }

      context.attributes field_id_name, after:, before:
    end

    def define_getter_for(reference, field_id_name:, klass:)
      context.define_method(reference) do
        instance_variable_get(:"@#{reference}") || begin
          field_id = attributes[field_id_name]
          instance_variable_set :"@#{reference}", klass.find(field_id) if field_id
        end
      end
    end

    def define_setter_for(reference, field_id_name:)
      after_set = options[:after]
      before_set = options[:before]

      context.define_method(:"#{reference}=") do |instance|   # def person=(instance)
        before_set&.call(self)                                #   before_set.call(self) if before_set

        attributes[field_id_name] = instance&.id              #   attributes[:person_id] = instance&.id
        instance_variable_set :"@#{reference}", instance      #   @person = instance

        after_set&.call(self)                                 #   after_set.call(self) if after_set

        instance # the standard setter returns                #   person # the standard setter returns
      end
    end
  end
end
