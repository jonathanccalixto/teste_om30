# frozen_string_literal: true

json.extract! municipe, :id, :name, :cpf, :cns, :email, :birthday, :phone, :status, :created_at, :updated_at
json.url municipe_url(municipe, format: :json)
