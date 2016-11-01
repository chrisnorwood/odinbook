class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :set_profile_photo

  def show
    @user = User.find(params[:id])
  end

  def set_profile_photo
    photo = Photo.find(params[:photo_id])
    user  = current_user
    user.profile_photo = photo
    if user.save
      flash[:notice] = "Profile photo updated"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def correct_user
      photo = current_user.photos.find_by(id: params[:photo_id])
      redirect_to root_url if photo.nil?
    end
end
