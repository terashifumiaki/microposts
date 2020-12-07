class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    post = Micropost.find(params[:micropost_id])
    current_user.like(post)
    flash[:success] = '投稿をお気に入りしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Micropost.find(params[:micropost_id])
    current_user.unlike(post)
    flash[:success] = '投稿のお気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end

# testコメント