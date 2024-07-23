# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :post_event
  belongs_to :user
  
  validates :user_id, uniqueness: {scope: :post_event_id}
  # １ユーザーに対して１favのみ許可する
end
