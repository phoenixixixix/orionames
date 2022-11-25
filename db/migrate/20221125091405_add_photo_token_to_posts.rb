class AddPhotoTokenToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :photo_token, :string
  end
end
