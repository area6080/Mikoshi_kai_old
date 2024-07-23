# frozen_string_literal: true

class CreateUnions < ActiveRecord::Migration[6.1]
  def change
    create_table :unions do |t|
      t.integer :post_event_id,         null: false
      t.integer :user_id,               null: false

      t.timestamps
    end
    add_index :unions, [:user_id, :post_event_id], unique: true
  end
end
