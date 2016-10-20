require 'test_helper'

class CommentControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @comment = comments(:one)
    @post    = @comment.commentable
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post post_comments_path(@post), params: { comment: { body: "Fake comment" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy for wrong comment" do
    sign_in users(:dan)
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to root_url
  end
end
