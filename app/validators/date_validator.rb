# frozen_string_literal: true

class DateValidator < ActiveModel::EachValidator
  include ActiveModel::Validations::Comparability
  include ActiveModel::Validations::ResolveValue

  def validate_each(record, attribute, value)
    value_before_type_cast = record.public_send(:"#{attribute}_before_type_cast")

    if check_mandatory?(value, value_before_type_cast)
      record.errors.add attribute, :blank
    elsif check_accordance?(value, value_before_type_cast)
      record.errors.add attribute, :invalid, **error_options(value: value_before_type_cast)
    else
      return if (allow_blank && value.blank?) || (allow_nil && value.nil?)

      check_comparison(record, attribute, value)
    end
  end

  private

  def error_options(**)
    options.except(*COMPARE_CHECKS.keys, :required, :allow_blank, :allow_nil).merge!(**)
  end

  def check_mandatory?(value, value_before_type_cast)
    options.fetch(:required, false) && value.blank? && value_before_type_cast.blank?
  end

  def check_accordance?(value, value_before_type_cast)
    value.blank? && value_before_type_cast.present?
  end

  def allow_blank
    options.fetch(:allow_blank, false)
  end

  def allow_nil
    options.fetch(:allow_nil, false)
  end

  def compare(value, operator, data)
    value.public_send(operator, data)
  end

  def check_comparison(record, attribute, value)
    options.slice(*COMPARE_CHECKS.keys).each do |option, raw_option_value|
      option_value = resolve_value(record, raw_option_value)

      next if compare(value, COMPARE_CHECKS[option], option_value)

      record.errors.add(attribute, option, **error_options(value:, count: option_value))
    rescue ArgumentError => e
      record.errors.add(attr_name, e.message)
    end
  end
end
