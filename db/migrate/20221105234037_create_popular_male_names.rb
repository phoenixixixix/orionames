class CreatePopularMaleNames < ActiveRecord::Migration[7.0]
  def change
    create_table :popular_male_names do |t|
      t.integer :name_id
      t.string :name_title

      t.timestamps
    end
  end
end
