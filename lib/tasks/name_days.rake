namespace :name_days do
  desc "Refresh and Set celebration status for today/tomorrow"
  task update_celebration_status: :environment do
    NameDay.refresh_celebration_status

    today, tomorrow = Date.today, Date.tomorrow
    name_day_today = NameDay.find_by(day: today.day, month: today.month)
    name_day_tomorrow = NameDay.find_by(day: tomorrow.day, month: tomorrow.month)

    name_day_today.today! if name_day_today
    name_day_tomorrow.tomorrow! if name_day_tomorrow
  end
end
