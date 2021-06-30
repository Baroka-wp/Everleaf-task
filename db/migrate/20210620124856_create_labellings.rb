class CreateLabellings < ActiveRecord::Migration[5.2]
  def change
    create_table :labellings do |t|

      t.timestamps
    end
  end
end
