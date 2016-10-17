class StaticPagesController < ApplicationController
  def home
    unless user_signed_in?
      redirect_to new_user_session_url
    end
  end
end