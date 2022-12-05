require "./lib/letters"

class Name < ApplicationRecord
  include Letters

  belongs_to :origin_country, optional: true
  has_one :wiki, dependent: :destroy
  has_one :famous_people_list, dependent: :destroy

  accepts_nested_attributes_for :wiki

  enum category: { male: 0, female: 1}

  before_save -> { fete_days.uniq!}
  before_create -> { title.capitalize! }
  before_create :populate_capital_letter
  after_commit :populate_name_days

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validate :fete_day_format

  scope :by_category, ->(category) { where(category: category) }
  scope :by_origin, ->(origin) { where(origin_country: origin) }
  scope :by_letter, ->(letter) { where(capital_letter: letter) }

  def human_category
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{self.category}")
  end

  def self.apply_filters(filters_hash)
    names = self
    filters_hash.each { |by_filter, value| names = names.public_send(by_filter, value) }

    names
  end

  private

  def populate_name_days
    fete_days.each do |date|
      name_day = NameDay.find_or_initialize_by(day: date.day, month: date.month)
      name_day.names_list << title
      name_day.save
    end
  end

  def populate_capital_letter
    self.capital_letter = title.first
  end

  def fete_day_format
    if fete_days_changed?
      fete_days.each do |date|
        # Only String or ::TimeWithZone will pass, because of errors
        # on interaction Date class with psql datetime format when array: true
        errors.add(:fete_days, "wrong input") unless [String, ActiveSupport::TimeWithZone].include? date.class
      end
    end
  end
end
