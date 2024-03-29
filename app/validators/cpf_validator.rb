# frozen_string_literal: true

class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if CPF.valid?(value) && /\A\d+\z/.match?(value.to_s)

    error_options = options.except(:allow_blank, :allow_nil).merge!(value:)
    record.errors.add attribute, :invalid, **error_options
  end
end
