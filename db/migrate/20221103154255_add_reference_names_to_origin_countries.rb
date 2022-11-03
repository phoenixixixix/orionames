class AddReferenceNamesToOriginCountries < ActiveRecord::Migration[7.0]
  def change
    add_reference :names, :origin_country, foreign_key: true
  end
end
