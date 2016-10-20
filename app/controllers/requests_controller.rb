class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @request = current_user.requests.new(friend: @user)

    if @request.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
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