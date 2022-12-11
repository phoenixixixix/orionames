class AddPinnedColumnToSelections < ActiveRecord::Migration[7.0]
  def change
    add_column :selections, :pinned, :boolean, default: false
  end
end
