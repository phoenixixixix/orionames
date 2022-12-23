require "test_helper"

class CelebrationStatusTest < ActiveSupport::TestCase
  setup do
    @sample_names_list = %w(NameDayName1 NameDayName2)
    @name_day = NameDay.new(day: 2, month: 2, names_list: @sample_names_list)
  end

  test "name day with celebration status today" do
    @name_day.today!
    @name_day.save

    nd_today = NameDay.celebration_today

    assert_equal nd_today, @name_day
  end

  test "name day with celebration status tomorrow" do
    @name_day.tomorrow!
    @name_day.save

    nd_tomorrow = NameDay.celebration_tomorrow

    assert_equal nd_tomorrow, @name_day
  end

  test "refresh celebration status for all name days" do
    nd_today = NameDay.create!(day: 1, month: 9, names_list: @sample_names_list)
    nd_tomorrow = NameDay.create!(day: 2, month: 9, names_list: @sample_names_list)
    nd_today.today!
    nd_tomorrow.tomorrow!
    assert_equal ["today", "tomorrow"], [nd_today.celebration_status, nd_tomorrow.celebration_status]

    NameDay.refresh_celebration_status

    assert_not_equal "today", nd_today.reload.celebration_status
    assert_not_equal "tomorrow", nd_tomorrow.reload.celebration_status
  end
end