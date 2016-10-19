require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @user = users(:chris)
    @friend = users(:dan)

    @request = @user.requests.build(friend: @friend)
  end

  test "should be valid" do
    assert @request.valid?
  end

  test "friend should not be nil" do
    @request.friend = nil
    assert_not @request.valid?
  end

  test "user should not be nil" do
    @request.user = nil
    assert_not @request.valid?
  end
end
