require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:chris)
    @post = @user.posts.build(body: "This is a test")
  end

  test "should be valid" do
    assert @post.valid?
  end
  
  test "body should be present" do
    @post.body = "          "
    assert_not @post.valid?
  end
end
