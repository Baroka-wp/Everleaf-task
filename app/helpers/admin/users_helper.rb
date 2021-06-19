module Admin::UsersHelper
	def is_admin
		if current_user.admin == false
			redirect_to tasks_path
		end
	end
end
