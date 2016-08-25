class LikesController < ApplicationController
  before_action :require_login, only: [:add_likes, :unlike]
  
  def add_likes
    Like.create(user: current_user, secret: Secret.find(params[:secret_id]))
    redirect_to '/secrets'
  end

  def unlike
  	Like.destroy(Like.select(:id).where(user: current_user, secret: Secret.find(params[:secret_id])))
  	redirect_to '/secrets'
  end

end
