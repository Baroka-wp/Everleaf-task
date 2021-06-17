class AddIndexToTasksTaskName < ActiveRecord::Migration[5.2]
  def change
  	add_index :tasks, :task_name
  end
end
