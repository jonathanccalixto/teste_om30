# frozen_string_literal: true

class MunicipeDecorator < ApplicationDecorator
  def birthday
    return unless record.birthday

    l record.birthday
  end

  def phone
    record.phone.to_s.gsub(/\A(\+\d\d)(\d\d)?(\d{4,5})(\d{4})/, '\1 \2 \3-\4').squish
  end
end
