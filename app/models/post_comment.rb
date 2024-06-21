class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_event

  validates :comment, presence: true

  def self.latest
    order(created_at: :desc)
  end
end
