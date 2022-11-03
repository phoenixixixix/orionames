class OriginCountry < ApplicationRecord
  has_many :names

  validates :title, :uk_title, :uk_title_plural, presence: true
end
