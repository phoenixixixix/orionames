class SelectionBelongsToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :selections, :post, foreign_key: true
  end
end
