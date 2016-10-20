class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes,    as: :likeable

  default_scope -> { order(created_at: :desc) }

  validates :body, presence: true
end
