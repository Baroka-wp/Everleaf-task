class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_name, :string
    add_column :tasks, :description, :string
    add_column :tasks, :status, :string
    add_column :tasks, :priority, :string
    add_column :tasks, :deadline, :date
  end
end
