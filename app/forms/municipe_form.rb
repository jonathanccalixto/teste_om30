# frozen_string_literal: true

class MunicipeForm < ApplicationForm
  references :municipe

  attributes :name, :cns, :cpf, :email, :birthday, :phone, :zip_code, :street,
             :number, :complement, :neighbourhood, :city, :state, :ibge

  validate :municipe_integrity, :address_integrity

  protected

  def initialize_municipe
    self.municipe = Municipe.find_or_initialize_by(id: municipe_id)
  end

  def perform
    initialize_municipe

    municipe.attributes = municipe_attributes.merge(address_attributes:)

    municipe.save
  end

  def municipe_attributes
    attributes.slice(:name, :cns, :cpf, :email, :birthday, :phone)
  end

  def address_attributes
    attributes.slice(:street, :number, :complement, :neighbourhood, :city, :state, :ibge)
  end

  def municipe_integrity
    model = initialize_municipe

    model.attributes = municipe_attributes

    extract_errors_from model if model.invalid?
  end

  def address_integrity
    model = Address.new address_attributes

    extract_errors_from model if model.invalid?
  end
end
