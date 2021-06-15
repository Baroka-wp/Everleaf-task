class TasksController < ApplicationController
	before_action :set_task, only: [:edit, :update, :show, :destroy]
	def index
		if params[:sort_expired]
			@tasks = Task.all.order('deadline DESC')
		else
			@tasks = Task.all.order('created_at DESC')
		end
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
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
		params.require(:task).permit(:task_name,:description,:status, :priority, :deadline)
	end

	def set_task
		@task = Task.find(params[:id])
	end
end
