class AddLabelRefToLabellings < ActiveRecord::Migration[5.2]
  def change
    add_reference :labellings, :label, foreign_key: true
  end
end
