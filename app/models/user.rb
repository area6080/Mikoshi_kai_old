class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_events, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :unions, dependent: :destroy

  validates :name, presence: true

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_fit: [width, height]).processed
  end

  def self.looks(word)
    User.where("name LIKE?","%#{word}%")
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "GuestUser"
      user.introduction = "神輿會の機能をどうぞご確認ください！"
      user.profile_image.attach(io: File.open("#{Rails.root}/app/assets/images/guest.jpg"), filename: "guest.jpg")
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
