# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if URI::MailTo::EMAIL_REGEXP.match?(value.to_s)

    error_options = options.except(:allow_blank, :allow_nil).merge!(value:)
    record.errors.add attribute, :invalid, **error_options
  end
end
