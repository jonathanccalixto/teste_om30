# frozen_string_literal: true

class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    error_options = options.except(:allow_blank, :allow_nil).merge(value:)

    if /\A\+\d+\z/.match?(value.to_s)
      record.errors.add attribute, :invalid, **error_options
    else
      count = 8
      record.errors.add attribute, :too_short, **error_options.merge(count:) if value.length < count
    end
  end
end
