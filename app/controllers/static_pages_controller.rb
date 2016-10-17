class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user

    # TO BE: feed
    @posts = current_user.posts
  end
end