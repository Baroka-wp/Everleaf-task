class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :edit, :update, :show]

  def new
  	if logged_in?
  		redirect_to tasks_path
  	else
    	@user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	session[:user_id] = @user.id
      	redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
  		redirect_to tasks_path
  	end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to user_path(@user.id), notice: "Profil edited!"
    else
        render :edit
    end
  end
  
  def show
  	@user = User.find(params[:id])
  	if current_user.id != @user.id
  		redirect_to tasks_path
  	end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                              	 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end