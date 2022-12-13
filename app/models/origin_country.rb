class OriginCountry < ApplicationRecord
  default_scope { order(:title) }

  has_many :names

  validates :title, presence: true
end
