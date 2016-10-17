class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
    @post = @user.posts.build
  end
end