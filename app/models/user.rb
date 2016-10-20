class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_many :requests, dependent: :destroy
  has_many :pending_friends, through: :requests, source: :friend
  
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Should split this into comment type, once pictures added
  has_many :comments
  # split into like type??
  has_many :likes

  validates :name, presence: true, length: { maximum: 50 }
end
