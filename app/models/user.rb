class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :post_events, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :profile_image
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end

  # def get_profile_image(*size)
  #   unless profile_image.attached?
  #     file_path = Rails.root.join('app/assets/images/no-image.png')
  #     profile_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
  #   end
    
  #   if !size.empty?
  #     profile_image.variant(resize: size)
  #   else
  #     profile_image
  #   end
  # end