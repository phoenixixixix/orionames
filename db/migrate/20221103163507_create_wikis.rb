class CreateWikis < ActiveRecord::Migration[7.0]
  def change
    create_table :wikis do |t|
      t.text :origin
      t.text :meaning
      t.belongs_to :name, null: false

      t.timestamps
    end
  end
end
