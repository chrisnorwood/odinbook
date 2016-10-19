require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @post = posts(:one)
    @comment = @post.comments.build(body: "Wow!! This is a comment!")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "body should not be blank" do
    @comment.body = '        '
    assert_not @comment.valid?
  end
end