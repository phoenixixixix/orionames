class Wiki < ApplicationRecord
  belongs_to :name

  validates :origin, :meaning, presence: true, length: { maximum: 500 }
end
