require "./lib/letters"

class Name < ApplicationRecord
  include Letters

  belongs_to :origin_country, optional: true
  has_one :wiki, dependent: :destroy

  accepts_nested_attributes_for :wiki

  enum category: { male: 0, female: 1}

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  validate :fete_day_format

  def human_category
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{self.category}")
  end

  def fits_to_query(query)
    # TODO
    true
  end

  private

  def fete_day_format
    if fete_days_changed?
      fete_days.each do |date|
        errors.add(:fete_days, "wrong input") unless [Date, ActiveSupport::TimeWithZone].include? date.class
      end
    end
  end
end
