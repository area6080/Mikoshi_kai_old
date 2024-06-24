class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_event

  validates :comment, presence: true
  
  scope :latest, -> {order(created_at: :desc)}
  # def self.latest
  #   order(created_at: :desc)
  # end
end
