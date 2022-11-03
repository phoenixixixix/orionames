class AddNameDaysToNames < ActiveRecord::Migration[7.0]
  def change
    add_column :names, :fete_days, :datetime, array: true, default: []
  end
end
