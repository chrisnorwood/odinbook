require 'will_paginate/array'

class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user

    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 20)
  end
end