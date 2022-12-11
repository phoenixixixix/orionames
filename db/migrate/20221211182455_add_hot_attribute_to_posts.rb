class AddHotAttributeToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :hot, :boolean, default: false
  end
end
