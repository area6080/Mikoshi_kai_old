# frozen_string_literal: true

class Tag < ApplicationRecord
  belongs_to :post_event
end
