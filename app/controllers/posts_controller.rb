class PostsController < ApplicationController
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post saved"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end
end