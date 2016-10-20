require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @user   = users(:josh)
    @friend = users(:jim)

    @request = @user.requests.build(friend: @friend)
  end

  test "should be valid" do
    assert @request.valid?
  end
end
