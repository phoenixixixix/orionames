class AddSlugToNames < ActiveRecord::Migration[7.0]
  def change
    add_column :names, :slug_en, :string
    add_column :names, :slug_uk, :string
    add_index :names, :slug_en, unique: true
    add_index :names, :slug_uk, unique: true
  end
end
