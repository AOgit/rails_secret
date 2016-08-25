class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create_secret, :destroy_secret]

  def index
    @secrets = Secret.all
  end

  def create_secret
  	current_user.secrets.create(content: params[:new_secret])
    # Secret.create(content: params[:new_secret], user: User.find(session[:user_id]))
    redirect_to "/users/#{current_user.id}"
  end

  def destroy_secret
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end

end