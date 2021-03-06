class LikeController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def create
    @like = Like.new(
     user_id: @current_user.id,
     post_id: params[:id]
    )
    @like.save
    redirect_to("/posts/index")

  end

  def destroy
    @like = Like.find_by(
     user_id: @current_user.id,
     post_id: params[:id]
    )
    if @like.destroy

    else
      flash[:notice] = "destroyできなかった"
    end
    redirect_to("/posts/index")
  end
end