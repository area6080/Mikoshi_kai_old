class PostEvent < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :unions, dependent: :destroy

  has_many :tags, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :event_date, presence: true
  validates :address, presence: true


  geocoded_by :address
  after_validation :geocode

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpg")
    end
    image.variant(resize_to_fit: [width, height]).processed
    # resize_to_limit
  end
  
  # def create_tag
  #   tags = Vision.get_image_data(self.image)
  #   tags.each do |tag|
  #     self.tags.create(name: tag)
  #   end
  # end

  def self.looks(word)
    PostEvent.where("title LIKE?", "%#{word}%")
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def join_in?(user)
    unions.exists?(user_id: user.id)
  end
end
