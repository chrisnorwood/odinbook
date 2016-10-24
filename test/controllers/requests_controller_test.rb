require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    # Friends
    @chris = users(:chris)
    @dan   = users(:dan)
    # Not friends
    @josh = users(:josh)
    @jim  = users(:jim)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Request.count' do
      post user_requests_path(@jim)
    end
    assert_redirected_to new_user_session_path
  end

  test "should create request if logged in" do
    sign_in @josh
    assert_difference 'Request.count' do
      post user_requests_path(@jim)
    end
  end
end