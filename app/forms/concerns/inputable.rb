# frozen_string_literal: true

module Inputable
  extend ActiveSupport::Concern

  included do
    protected :read_attribute, :write_attribute
  end

  class_methods do
    def attribute_names
      Thread.current[:attribute_names] ||= []
    end

    def attributes(*)
      InputMaker.new(self, *).make
    end
  end

  def initialize(*, **)
    @attributes = self.class
                      .attribute_names.index_with { nil }
                      .with_indifferent_access

    super(*, **)
  end

  def attribute_names
    self.class.attribute_names
  end

  def attributes
    @attributes.dup
  end

  def attributes=(attrs)
    attrs.each do |key, value|
      public_send(:"#{key}=", value)
    end
  end

  def read_attribute(attr)
    @attributes.dup[attr]
  end

  def write_attribute(attr, value)
    @attributes[attr] = value
  end

  class InputMaker
    def initialize(context, *attrs)
      @context = context
      @options = attrs.extract_options!
      @attrs = attrs
    end

    def make
      attrs.each do |attr|
        context.attribute_names << attr.to_sym

        define_getter_for(attr)
        define_setter_for(attr)
      end

      context.attribute_names.uniq!

      nil
    end

    private

    attr_reader :context, :options, :attrs

    def define_getter_for(attr)
      context.define_method(attr) { read_attribute(attr) }
    end

    def define_setter_for(attr)
      method_name = :"#{attr}="
      after_set, before_set, readonly = options.values_at(:after, :before, :readonly)

      context.define_method(method_name) do |value|
        raise NoMethodError, "undefined method `#{method_name}' for #{self}" if readonly

        before_set&.call(self)

        write_attribute(attr, value)

        after_set&.call(self)

        value # the standard setter returns
      end
    end
  end
end
