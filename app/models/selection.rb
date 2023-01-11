class Selection < ApplicationRecord
  paginates_per 6

  belongs_to :post, optional: true

  validates :title, presence: true
  validate :names_exactly_10
  validate :numeric_key_in_names

  scope :pinned, ->{ where(pinned: true) }

  def ids_to_names_hash
    # Transform ids from params[:names] to hash
    self.names = Name.find(names).pluck(:id, :title).to_h
  end

  private

  def names_exactly_10
    errors.add(:names, :names_exactly_10) if names.count != 10
  end

  def numeric_key_in_names
    return unless names
    names.each do |id, _|
      if id.match?(/\D/)
        errors.add(:names, :numeric_key_in_names)
        break
      end
    end
  end
end
