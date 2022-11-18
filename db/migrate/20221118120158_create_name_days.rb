class CreateNameDays < ActiveRecord::Migration[7.0]
  def change
    create_table :name_days do |t|
      t.integer :day, null: false
      t.integer :month, null: false
      t.string :names_list, array: true, default: []
      t.integer :celebration_status, default: 0

      t.timestamps
    end
  end
end
