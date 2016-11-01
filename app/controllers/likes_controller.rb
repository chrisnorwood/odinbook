class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    # @post = Post.find(params[:post_id])
    @likeable = get_likeable

    @like = @likeable.likes.build
    @like.user_id = current_user.id
    if @like.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @like.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private
    def correct_user
      @like = current_user.likes.find_by(id: params[:id])
      redirect_to root_url if @like.nil?
    end

    def get_likeable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end