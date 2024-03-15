# frozen_string_literal: true

class Municipe < ApplicationRecord
  enum :status, { active: 'active', inactive: 'inactive' }, validate: true

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize: '100x100'
    attachable.variant :medium, resize: '300x300', monochrome: true
  end

  validates :name, presence: true
  validates :cpf, presence: true,
                  cpf: { allow_blank: true },
                  uniqueness: { allow_blank: true }
  validates :cns, presence: true,
                  cns: { allow_blank: true },
                  uniqueness: { allow_blank: true }
  validates :email, presence: true,
                    email: { allow_blank: true }
  validates :birthday, date: { required: true, less_than: -> { Date.current } }
  validates :phone, presence: true, phone: { allow_blank: true }
end
