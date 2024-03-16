# frozen_string_literal: true

class CnsValidator < ActiveModel::EachValidator
  INVALID_CNS = %w[
    000000000000000
    111111111111111
    222222222222222
    333333333333333
    444444444444444
    555555555555555
    666666666666666
    777777777777777
    888888888888888
    999999999999999
  ].freeze

  def validate_each(record, attribute, value)
    return if valid_length?(value.to_s) && !invalid_cns?(value.to_s) && valid_checksum?(value.to_s)

    error_options = options.except(:allow_blank, :allow_nil).merge!(value:)
    record.errors.add attribute, :invalid, **error_options
  end

  private

  def valid_length?(cns)
    cns.length == 15
  end

  def invalid_cns?(cns)
    INVALID_CNS.include?(cns)
  end

  def valid_checksum?(cns)
    case cns[0]
    when '1', '2'
      valid_cns?(cns)
    when '7', '8', '9'
      valid_provisional_cns?(cns)
    else
      false
    end
  end

  def valid_cns?(cns)
    pis = extract_pis(cns)
    sum = calculate_sum(pis)
    dv = calculate_dv(sum)

    if dv == 10
      sum += 2
      dv = calculate_dv(sum)
      cns == "#{pis.join}001#{dv}"
    else
      cns == "#{pis.join}000#{dv}"
    end
  end

  def extract_pis(cns)
    cns[0, 11].chars.map(&:to_i)
  end

  def calculate_sum(pis)
    pis.each_with_index.sum { |digit, index| digit * (15 - index) }
  end

  def calculate_dv(sum)
    dv = 11 - (sum % 11)
    dv.zero? ? 0 : dv
  end

  def valid_provisional_cns?(cns)
    sum = cns.chars.each_with_index.sum { |digit, index| digit.to_i * (15 - index) }
    (sum % 11).zero? && cns.length == 15
  end
end
