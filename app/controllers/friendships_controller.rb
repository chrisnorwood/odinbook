class FriendshipsController < ApplicationController
  before_action :correct_user, only: :destroy

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends.paginate(page: params[:page], per_page: 20)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end

  def find_new
    @user           = current_user
    current_friends = @user.friends
    @new_friends    = User.all.reject { |friend| current_friends.include?(friend) || friend == @user }
    @new_friends    = @new_friends.paginate(page: params[:page], per_page: 50)
  end

  private

    def correct_user
      @friendship = current_user.friendships.find_by(id: params[:id])
      redirect_back(fallback_location: root_path) if @friendship.nil?
    end
end