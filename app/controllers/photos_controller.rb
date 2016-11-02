class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:file, :description)
    end

    def correct_user
      @photo = current_user.photos.find_by(id: params[:id])
      redirect_to root_url if @photo.nil?
    end
end