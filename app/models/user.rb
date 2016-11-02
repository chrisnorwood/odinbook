class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :posts,  dependent: :destroy
  has_many :photos, dependent: :destroy

  belongs_to :profile_photo, class_name: 'Photo', foreign_key: 'profile_photo_id'

  has_many :requests, dependent: :destroy
  has_many :sent_requests,     class_name: 'Request', foreign_key: 'user_id', 
                               dependent: :destroy
  has_many :received_requests, class_name: 'Request', foreign_key: 'friend_id', 
                               dependent: :destroy
  
  has_many :friends_requested,  through: :sent_requests,     source: :friend
  has_many :friends_requesting, through: :received_requests, source: :user


  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :comments
  has_many :likes

  validates :name, presence: true, length: { maximum: 50 }

  def feed
    ids = self.friends.pluck(:id) << self.id
    posts    = Post.where(user_id: ids)
    photos   = Photo.where(user_id: ids)
    combined = ( posts + photos ).sort_by(&:created_at).reverse

    return combined
  end

  def personal_feed
    posts  = self.posts
    photos = self.photos
    combined = ( posts + photos ).sort_by(&:created_at).reverse

    return combined
  end

  def profile_photo_path
    if profile_photo.nil?
      'fallback/default.jpg'
    else
      profile_photo.file.url(:thumb)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
