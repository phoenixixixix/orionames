class RemoveFeteDaysInNames < ActiveRecord::Migration[7.0]
  def up
    remove_column :names, :fete_days
  end

  def down
    add_column :names, :fete_days, :datetime, array: true, default: []
  end
end
