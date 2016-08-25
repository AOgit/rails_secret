class UsersController < ApplicationController
  before_action :require_login, except: [:index, :login, :new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
  	if user = current_user
  	  redirect_to "/users/#{user.id}"
  	end
  end

  def login
	  user = User.find_by(email: params[:session][:email].downcase)
	  if user && user.authenticate(params[:session][:password])
	  	session[:user_id] = user.id
	  	redirect_to "/users/#{current_user.id}"
	  else
	  	flash[:error] = "Invalid"
	  	redirect_to :back
	  end
  end

  def logout
  	session.delete(:user_id)
  	redirect_to "/sessions/new"
  end

  def show
  	@user = User.find(params[:id])
    @secrets = @user.secrets
  end

  def new
  	if user = current_user
  	  redirect_to "/users/#{user.id}"
  	end
  end

  def create
    user = User.create(user_params)
    if user.valid?
      last_user = User.last
      session[:user_id] = last_user.id
      redirect_to "/users/#{current_user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	current_user.update(name: params[:name], email: params[:email])
  	redirect_to "/users/#{current_user.id}"
  end

  def destroy
  	User.find(params[:id]).destroy
  	session.delete(:user_id)
    redirect_to "/sessions/new"
  end

  private 

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end	

end
