# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :post_event
  belongs_to :user
end
