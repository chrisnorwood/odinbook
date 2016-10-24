class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, dependent: :destroy

  has_many :requests, dependent: :destroy
  has_many :sent_requests,     class_name: 'Request', foreign_key: 'user_id', 
                               dependent: :destroy
  has_many :received_requests, class_name: 'Request', foreign_key: 'friend_id', 
                               dependent: :destroy
  
  has_many :friends_requested,  through: :sent_requests,     source: :friend
  has_many :friends_requesting, through: :received_requests, source: :user


  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Should split this into comment type, once pictures added
  has_many :comments
  # split into like type??
  has_many :likes

  mount_uploader :picture, PictureUploader

  validates_integrity_of :picture
  validates_processing_of :picture
  validate :picture_size
  validates :name, presence: true, length: { maximum: 50 }

  def feed
    ids = self.friends.pluck(:id) << self.id
    Post.where(user_id: ids)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.picture = auth.info.image
    end
  end

  private

    def picture_size
      errors[:picture] << "should be less than 500KB" if picture.size > 0.5.megabytes
    end
end
