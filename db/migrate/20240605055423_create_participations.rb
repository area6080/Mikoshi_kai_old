# frozen_string_literal: true

class CreateParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :participations do |t|
      t.integer :user_id,         null: false
      t.integer :group_id,         null: false

      t.timestamps
    end
    add_index :participations, [:user_id, :group_id], unique: true
  end
end
