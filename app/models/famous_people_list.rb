class FamousPeopleList < ApplicationRecord
  belongs_to :name
  before_save -> { names.delete("") }
end
