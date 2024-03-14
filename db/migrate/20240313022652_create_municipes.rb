# frozen_string_literal: true

class CreateMunicipes < ActiveRecord::Migration[7.1]
  def change
    create_table :municipes do |t|
      t.string :name, null: false, default: '', index: true
      t.string :cpf, null: false, default: '', index: { unique: true }
      t.string :cns, null: false, default: '', index: { unique: true }
      t.string :email, null: false, default: '', index: true
      t.date :birthday, null: false
      t.string :tellphone, null: false, default: '', index: true
      t.string :status, null: false, default: 'active', index: true

      t.datetime :inactivated_at
      t.timestamps
    end
  end
end
