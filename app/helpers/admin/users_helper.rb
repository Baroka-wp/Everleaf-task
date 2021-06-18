module Admin::UsersHelper
	def choose_new_or_edit
	    if action_name == 'new' || action_name == 'create' || action_name == 'confirm' 
	      confirm_posts_path
	    elsif action_name == 'edit'
	      admin_users_path
	    end
	end
end
