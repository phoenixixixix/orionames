require "test_helper"

class NameScopesTest < ActiveSupport::TestCase
  setup do
    @in_scope_name = Name.create!(title: "InScope", category: 0)
    @out_scope_name = Name.create!(title: "OutScope", category: 1)
  end

  test "get names by category" do
    MATCHING_CATEGORY = "male"
    @in_scope_name.update!(category: MATCHING_CATEGORY)
    @out_scope_name.update!(category: "female")

    retrieved_by_category = Name.by_category(MATCHING_CATEGORY)

    assert_includes retrieved_by_category, @in_scope_name
    assert_not_includes retrieved_by_category, @out_scope_name
  end

  test "get names by origin country" do
    MATCHING_ORIGIN_COUNTRY = OriginCountry.create!(title: "ToMatch")
    @in_scope_name.update!(origin_country: MATCHING_ORIGIN_COUNTRY)
    @out_scope_name.update!(origin_country: origin_countries(:default))

    retrieved_by_origin_country = Name.by_origin(MATCHING_ORIGIN_COUNTRY.title)

    assert_includes retrieved_by_origin_country, @in_scope_name
    assert_not_includes retrieved_by_origin_country, @out_scope_name
  end

  test "get names by capital letter" do
    MATCHING_CAPITAL_LETTER = "A"
    @in_scope_name.update!(title: "#{MATCHING_CAPITAL_LETTER}letter")
    @out_scope_name.update!(title: "Bletter")

    retrieved_by_capital_letter = Name.by_letter(MATCHING_CAPITAL_LETTER)

    assert_includes retrieved_by_capital_letter, @in_scope_name
    assert_not_includes retrieved_by_capital_letter, @out_scope_name
  end
end