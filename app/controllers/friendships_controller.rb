class FriendshipsController < ApplicationController
  before_action :correct_user, only: :destroy

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def correct_user
      @friendship = current_user.friendships.find_by(id: params[:id])
      redirect_back(fallback_location: root_path) if @friendship.nil?
    end
end