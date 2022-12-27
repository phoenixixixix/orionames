require "test_helper"

class NameDayTest < ActiveSupport::TestCase
  setup do
    @sample_names_list = %w(NameDayName1 NameDayName2)
    @name_day = NameDay.new(day: 2, month: 2, names_list: @sample_names_list)
  end

  test "valid name day" do
    assert @name_day.valid?
  end

  # Validations

  test "invalid without day or month" do
    @name_day.day = nil
    @name_day.month = nil

    refute @name_day.valid?

    assert_not_empty @name_day.errors[:day]
    assert_not_empty @name_day.errors[:month]
  end

  test "name day should be uniq depending on day and month" do
    @name_day.save
    not_uniq_nd = NameDay.new(day: @name_day.day, month: @name_day.month)

    refute not_uniq_nd.valid?

    assert_equal [@name_day.day, @name_day.month], [not_uniq_nd.day, not_uniq_nd.month]
    assert_includes not_uniq_nd.errors[:base], "Name Day already exists"
  end

  test "a name day names list should not be empty" do
    @name_day.names_list = []

    refute @name_day.valid?

    assert_not_empty @name_day.errors[:names_list]
    assert_includes @name_day.errors[:names_list], "names list shouldn't be empty"
  end

  # Callbacks

  test "a name day names list should save without white spaces and empty strings" do
    empty, white_spaces, start_end_ws = "", "   ", "   White Spaces   "

    @name_day.names_list = [empty, white_spaces, start_end_ws]

    @name_day.save

    assert_not_includes @name_day.names_list, empty
    assert_not_includes @name_day.names_list, white_spaces
    assert_not_includes @name_day.names_list, start_end_ws
    assert_includes @name_day.names_list, "White Spaces"
  end

  test "sanitize duplicated names in names_list" do
    @name_day.names_list = ["Duplication", "Duplication"]

    @name_day.save

    assert_equal 1, @name_day.names_list.count("Duplication")
  end

  # Scopes

  test "get name day by month" do
    MATCHING_MONTH = "january"
    in_scope_name_day = NameDay.create!(day: 2, month: MATCHING_MONTH, names_list: @sample_names_list)
    out_scope_name_day = NameDay.create!(day: 2, month: 9, names_list: @sample_names_list)

    retrieved_by_month = NameDay.by_month(MATCHING_MONTH)

    assert_includes retrieved_by_month, in_scope_name_day
    assert_not_includes retrieved_by_month, out_scope_name_day
  end
end
