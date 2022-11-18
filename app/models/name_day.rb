class NameDay < ApplicationRecord
  before_save -> { names_list.uniq!}

  enum month: { january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7,
                august: 8, september: 9, october: 10, november: 11, december: 12 }
  enum celebration_status: { empty: 0, today: 1, tomorrow: 2 }

  validates :day, :month, presence: true

  scope :by_month, ->(month) { where(month: month) }

  def self.celebration_today
    self.today.limit(1)[0]
  end

  def self.celebration_tomorrow
    self.tomorrow.limit(1)[0]
  end

  def human_day_month
    "#{day} #{month}"
  end
end
