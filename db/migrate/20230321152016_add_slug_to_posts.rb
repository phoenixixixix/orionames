class AddSlugToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :slug_en, :string
    add_column :posts, :slug_uk, :string
    add_index :posts, :slug_en, unique: true
    add_index :posts, :slug_uk, unique: true
  end
end
