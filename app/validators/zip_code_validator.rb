# frozen_string_literal: true

class ZipCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if /\A\d{8}\z/.match?(value.to_s)

    error_options = options.except(:allow_blank, :allow_nil).merge!(value:)
    record.errors.add attribute, :invalid, **error_options
  end
end
