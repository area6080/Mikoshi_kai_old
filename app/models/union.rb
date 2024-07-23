# frozen_string_literal: true

class Union < ApplicationRecord
  belongs_to :post_event
  belongs_to :user
  
  validates :user_id, uniqueness: {scope: :post_event_id}
end
