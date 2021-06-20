class AddTaskRefToLabellings < ActiveRecord::Migration[5.2]
  def change
    add_reference :labellings, :task, foreign_key: true
  end
end
