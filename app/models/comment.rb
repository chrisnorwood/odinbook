class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  default_scope -> { order(created_at: :asc) }

  validates :body, :commentable, { presence: true }
  validates :user_id, presence: true
end
