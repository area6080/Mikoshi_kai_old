# frozen_string_literal: true

class CreatePostEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :post_events do |t|
      t.integer :user_id,         null: false
      t.string :title,            null: false
      t.text :caption
      t.string :event_date,       null: false
      t.string :address,          null: false, default: ""
      t.float :latitude,          null: false, default: 0
      t.float :longitude,         null: false, default: 0

      t.timestamps
    end
  end
end
