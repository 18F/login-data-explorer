# frozen_string_literal: true

class AddDeviseToAdmins < ActiveRecord::Migration[5.2]
  def self.up
    create_table :admins do |t|
      ## Login.gov attributes
      t.string :email, null: false
      t.string :uuid

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
    end

    add_index :admins, :email
    add_index :admins, :uuid
  end

  def self.down
    drop_table :admins
  end
end
