class TasksController < ApplicationController
	before_action :set_task, only: [:edit, :update, :show, :destroy]
	def index
		all_tasks= Task.user_task_list(current_user.id)
		if params[:sort_expired]
			@tasks = all_tasks.order('deadline DESC').page params[:page]
		elsif params[:task_name].present?
			if params[:status].present?
				@tasks = all_tasks.task_name_search(params[:task_name]).status_search(params[:status]).page params[:page]
			else
				@tasks = all_tasks.task_name_search(params[:task_name]).page params[:page]
			end
		elsif params[:status].present?
			@tasks = all_tasks.status_search(params[:status]).page params[:page]
		elsif params[:label_id].present?
			@tasks = all_tasks.label_task_search(params[:label_id]).page params[:page]
		elsif params[:sort_priority]
			@tasks = all_tasks.priority_ordered.page params[:page]
		else
			@tasks = all_tasks.order('created_at DESC').page params[:page]
		end
	end

	def new
		@task = Task.new
		@labels = Label.all
	end

	def create
		@task = current_user.tasks.build(task_params)
		if params[:back]
	  		render :new
		else
			if @task.save
				redirect_to tasks_path, notice: "task created!"
			else
				render :new
			end
		end
	end


	def edit
	end

	def update
		if @task.update(task_params)
	  		redirect_to tasks_path, notice: "task edited!"
		else
	  		render :edit
		end
	end

	def show
	end

	def destroy
		@task.destroy
		redirect_to tasks_path, notice:"task deleted!"
	end

	private

	def task_params
		params.require(:task).permit(:task_name,:description,:status, :priority, :deadline, label_ids: [])
	end

	def set_task
		@task = Task.find(params[:id])
	end
end
