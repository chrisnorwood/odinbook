class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:user_id])
    @request = current_user.requests.new(friend: friend)

    if @request.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @request = Request.find(params[:id])
    @request.accept
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end
end