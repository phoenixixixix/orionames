class CreateOriginCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :origin_countries do |t|
      t.string :title
      t.string :uk_title
      t.string :uk_title_plural

      t.timestamps
    end
  end
end
