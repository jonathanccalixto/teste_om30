# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  include Inputable
  include Referenceable

  def self.i18n_scope
    :activeform
  end

  def self.create(attributes = {})
    form = new(attributes)
    form.save
    form
  end

  def self.create!(attributes = {})
    form = new(attributes)
    form.save!
    form
  end

  def save(options = {})
    save!(options)
  rescue ActiveRecord::RecordInvalid
    false
  end

  def save!(options = {})
    ApplicationRecord.transaction do
      raise_record_invalid unless perform_validations(options)

      perform

      true
    end
  end

  def update(attributes = {})
    self.attributes = attributes
    save
  end

  def update!(attributes = {})
    self.attributes = attributes
    save!
  end

  def as_json(*)
    attributes.as_json
  end

  def inspect
    inspection = attributes.map { |key, value| "#{key}: #{value.inspect}" }
    "#<#{self.class.name} #{inspection.join(', ')}>"
  end

  protected

  def perform
    raise NotImplementedError, 'not implemented'
  end

  def perform_validations(options = {}) # :nodoc:
    options[:validate] == false || valid?(options[:context])
  end

  def raise_record_invalid
    raise ActiveRecord::RecordInvalid, self
  end

  def extract_errors_from(record)
    record.errors.details.each do |field, details|
      next unless attribute_names.include?(field)

      details.each do |detail|
        error = detail.delete(:error)

        errors.add(field, error, **detail)
      end
    end
  end
end
