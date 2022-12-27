class AddDefaultValueForPhotoToken < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :photo_token
    add_column :posts, :photo_token, :string, default: ""
  end
end
