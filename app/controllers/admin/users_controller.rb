class Admin::UsersController < ApplicationController
	skip_before_action :login_required, only: [:edit, :update, :destroy, :show]
	before_action :is_admin, only: [:edit, :update, :destroy, :show,:index, :new]
	before_action :set_user, only: [:edit, :update, :destroy, :show]
	
	def index
		@users = User.select(:id, :name, :admin)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
		  	redirect_to admin_users_path
		else
		  	render :new
		end
	end

	def edit
	end

	def update
		if params[:admin]
			if @user.admin == true
				@user.update_attribute(:admin, false)
			else
				@user.update_attribute(:admin, true)
			end
		else
			if @user.update(user_params)
			    redirect_to admin_users_path, notice: "Profil edited!"
			else
			    render :edit
			end
		end
	end

	def show
	end

	def destroy
		@user.destroy
		redirect_to admin_users_path, notice:"User deleted!"
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,
	                          	 :password_confirmation)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def is_admin
		if current_user.admin == false || current_user.admin.blank?
			redirect_to tasks_path
		end
	end
end
