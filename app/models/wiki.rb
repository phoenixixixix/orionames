class Wiki < ApplicationRecord
  belongs_to :name

  validates :origin, :meaning, presence: true, length: { maximum: 1500 }
end
