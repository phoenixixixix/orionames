class NameDay < ApplicationRecord
  DEFAULT_MONTH = "january"

  enum month: { january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7,
                august: 8, september: 9, october: 10, november: 11, december: 12 }
  enum celebration_status: { empty: 0, today: 1, tomorrow: 2 }

  validates :day, :month, presence: true
  validate :name_day_uniqueness, on: :create
  validate :names_list_fullness

  before_validation :remove_white_spaces_and_empty_strings
  before_save -> { names_list.uniq!}

  scope :by_month, ->(month) { where(month: month) }

  def self.celebration_today
    find_by(celebration_status: :today)
  end

  def self.celebration_tomorrow
    find_by(celebration_status: :tomorrow)
  end

  def self.refresh_celebration_status
    celebrating = where(celebration_status: %w(today tomorrow))
    celebrating.each { |name_day| name_day.empty! }
  end

  def human_day_month
    "#{day} #{self.class.human_enum_name("numeral_month", month)}"
  end

  private

  def name_day_uniqueness
    errors.add(:base, :existing) if NameDay.find_by(day: day, month: month)
  end

  def names_list_fullness
    errors.add(:names_list, :empty) if names_list.empty?
  end

  def remove_white_spaces_and_empty_strings
    names_list.each { |name| name.strip! }.delete("")
  end
end
