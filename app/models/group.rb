class Group < ApplicationRecord
  has_many :participations, dependent: :destroy

  validates :name, presence: true

  def is_owned_by?(user)
    owner_id == user.id
  end

  def participation_in?(user)
    participations.exists?(user_id: user.id)
  end
end
