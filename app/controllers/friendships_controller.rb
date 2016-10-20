class FriendshipsController < ApplicationController
  before_action :correct_user

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