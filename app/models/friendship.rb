class Friendship < ApplicationRecord
  after_create  :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

    def create_inverse_relationship
      unless friend.friendships.find_by(friend: user)
        friend.friendships.create(friend: user)
      end
    end

    def destroy_inverse_relationship
      friendship = friend.friendships.find_by(friend: user)
      friendship.destroy if friendship
    end
end