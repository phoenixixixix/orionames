require "./lib/letters"

class Name < ApplicationRecord
  include Letters

  belongs_to :origin_country, optional: true
  has_one :wiki, dependent: :destroy

  accepts_nested_attributes_for :wiki

  enum category: { male: 0, female: 1}

  before_create -> { title.capitalize! }
  before_create :populate_capital_letter

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  validate :fete_day_format

  scope :category_filter, ->(category) { where(category: category) }
  scope :origin_filter, ->(origin) { where(origin_country: origin) }
  scope :letter_filter, ->(letter) { where(capital_letter: letter) }

  def human_category
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{self.category}")
  end

  def self.apply_filters(filters_hash)
    names_arr = self
    filters_hash.each { |name, value| names_arr = names_arr.send("#{name}_filter", value) }

    names_arr
  end

  private

  def populate_capital_letter
    self.capital_letter = title.first
  end

  def fete_day_format
    if fete_days_changed?
      fete_days.each do |date|
        errors.add(:fete_days, "wrong input") unless [Date, ActiveSupport::TimeWithZone].include? date.class
      end
    end
  end
end
