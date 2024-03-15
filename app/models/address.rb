# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :municipe

  validates :zip_code, presence: true, zip_code: { allow_blank: true }
  validates :street, presence: true
  validates :number, presence: true, format: { with: /\A(\d+[a-z]?|)\z/i, allow_blank: true }
  validates :neighbourhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
