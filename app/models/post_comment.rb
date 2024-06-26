class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_event

  validates :comment, presence: true
end
