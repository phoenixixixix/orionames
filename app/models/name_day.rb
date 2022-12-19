class NameDay < ApplicationRecord
  enum month: { january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7,
                august: 8, september: 9, october: 10, november: 11, december: 12 }
  enum celebration_status: { empty: 0, today: 1, tomorrow: 2 }

  before_validation :remove_white_spaces_and_empty_strings
  before_save -> { names_list.uniq!}

  validates :day, :month, presence: true
  validate :name_day_uniqueness, on: :create
  validate :names_list_fullness

  scope :by_month, ->(month) { where(month: month) }

  def self.celebration_today
    find_by(celebration_status: :today)
  end

  def self.celebration_tomorrow
    find_by(celebration_status: :tomorrow)
  end

  def human_day_month
    "#{day} #{month}"
  end

  private

  def name_day_uniqueness
    errors.add(:base, "Name Day already exists") if NameDay.find_by(day: day, month: month)
  end

  def names_list_fullness
    errors.add(:names_list, "name list empty") if names_list.empty?
  end

  def remove_white_spaces_and_empty_strings
    names_list.each { |name| name.strip! }.delete("")
  end
end
