# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :municipe, null: false, foreign_key: true
      t.string :zip_code, null: false, default: ''
      t.string :street, null: false, default: ''
      t.string :number, null: false, default: ''
      t.string :complement, null: false, default: ''
      t.string :neighbourhood, null: false, default: ''
      t.string :city, null: false, default: ''
      t.string :state, null: false, default: ''
      t.string :ibge, null: false, default: ''

      t.timestamps
    end
  end
end
