class CreateFamousPeopleLists < ActiveRecord::Migration[7.0]
  def change
    create_table :famous_people_lists do |t|
      t.belongs_to :name
      t.string :names, array: true

      t.timestamps
    end
  end
end
