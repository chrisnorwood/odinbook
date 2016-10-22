require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:chris)
    @other_user = users(:dan)

    @post = posts(:one)
    @like = likes(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Like.count' do
      post post_likes_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Like.count' do
      delete like_path(@like)
    end
    assert_redirected_to new_user_session_path
  end

  test "should create with valid user and logged in" do
    sign_in @user
    @other_post = posts(:two)
    assert_difference 'Like.count', 1 do
      post post_likes_path(@other_post)
    end
  end

  test "should not create if already liked" do
    sign_in @user
    post post_likes_path(@post)
    assert_no_difference 'Like.count' do
      post post_likes_path(@post)
    end
  end

  test "should delete when correct user" do
    sign_in @user
    assert_difference 'Like.count', -1 do
      delete like_path(@like)
    end
  end

  test "should not delete when incorrect user" do
    sign_in @other_user
    assert_no_difference 'Like.count' do
      delete like_path(@like)
    end
  end
end
