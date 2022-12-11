class Selection < ApplicationRecord
  paginates_per 6

  belongs_to :post, optional: true

  validates :title, presence: true
  validate :names_exactly_10

  scope :pinned, ->{ where(pinned: true) }

  def ids_to_names_hash
    # Transform ids from params[:names] to hash
    self.names = Name.find(names).pluck(:id, :title).to_h
  end

  private

  def names_exactly_10
    errors.add(:names, "Names number should be exactly 10") if names.count != 10
  end
end
