class AddCapitalLetterColumnToNames < ActiveRecord::Migration[7.0]
  def change
    add_column :names, :capital_letter, :string
  end
end
