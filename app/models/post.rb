class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable

  default_scope -> { order(created_at: :desc) }

  validates :body, presence: true
end
