class NameDay < ApplicationRecord
  enum month: { january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7,
                august: 8, september: 9, october: 10, november: 11, december: 12 }
  enum celebration_status: { empty: 0, today: 1, tomorrow: 2 }

  before_save -> { names_list.uniq!}

  validates :day, :month, presence: true

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
end
