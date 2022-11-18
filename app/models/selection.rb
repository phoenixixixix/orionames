class Selection < ApplicationRecord
  validates :title, presence: true
  validate :names_exactly_10

  private

  def names_exactly_10
    errors.add(:names, "Names number should be exactly 10") if names.count != 10
  end
end
