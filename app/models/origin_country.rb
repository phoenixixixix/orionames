class OriginCountry < ApplicationRecord
  has_many :names

  validates :title, presence: true
end
