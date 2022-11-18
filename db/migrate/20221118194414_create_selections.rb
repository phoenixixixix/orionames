class CreateSelections < ActiveRecord::Migration[7.0]
  def change
    create_table :selections do |t|
      t.string :title
      t.json :names

      t.timestamps
    end
  end
end
