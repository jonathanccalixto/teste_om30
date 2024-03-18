# frozen_string_literal: true

class MunicipeForm < ApplicationForm
  references :municipe

  attributes :name, :cns, :cpf, :email, :birthday, :phone, :zip_code, :street,
             :number, :complement, :neighbourhood, :city, :state, :ibge, :photo

  validate :municipe_integrity, :address_integrity

  def initialize(*, **)
    super

    initialize_municipe
  end

  delegate :persisted?, :new_record?, to: :municipe, allow_nil: true

  protected

  def initialize_municipe
    self.municipe = Municipe.find_or_initialize_by(id: municipe_id)
    # raise municipe.inspect
    municipe.build_address unless municipe.address

    %i[name cns cpf email birthday phone photo].each do |field|
      attributes[field] || write_attribute(field, municipe[field])
    end

    %i[street number complement neighbourhood city state ibge].each do |field|
      attributes[field] || write_attribute(field, municipe.address[field])
    end
  end

  def perform
    municipe.attributes = municipe_attributes.merge(address_attributes:)

    municipe.save
  end

  def municipe_attributes
    attributes.slice(:name, :cns, :cpf, :email, :birthday, :phone, :photo)
  end

  def address_attributes
    attributes.slice(:street, :number, :complement, :neighbourhood, :city, :state, :ibge)
  end

  def municipe_integrity
    model = municipe
    model.attributes = municipe_attributes

    extract_errors_from model if model.invalid?
  end

  def address_integrity
    model = municipe.adrress || Address.new
    model.attributes = address_attributes

    extract_errors_from model if model.invalid?
  end
end
