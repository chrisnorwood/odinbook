require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:chris)
    @friend = users(:dan)

    @friendship = @user.friendships.build(friend: @friend)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "friend should not be nil" do
    @friendship.friend = nil
    assert_not @friendship.valid?
  end

  test "user should not be nil" do
    @friendship.user = nil
    assert_not @friendship.valid?
  end

  test "should generate mutual inverse friendship upon save" do
    assert_difference 'Friendship.count', 2 do
      @friendship.save
    end
    assert @user.friends.include?(@friend)
    assert @friend.friends.include?(@user)
  end
end
