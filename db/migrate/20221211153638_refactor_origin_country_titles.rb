class RefactorOriginCountryTitles < ActiveRecord::Migration[7.0]
  def up
    remove_column :origin_countries, :uk_title
    remove_column :origin_countries, :uk_title_plural
  end

  def down
    add_column :origin_countries, :uk_title, :string
    add_column :origin_countries, :uk_title_plural, :string
  end
end
