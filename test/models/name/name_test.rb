require "test_helper"

class NameTest < ActiveSupport::TestCase
  setup do
    @name = Name.new(title: "TestName", category: 1, origin_country: origin_countries(:default))
  end

  # Validations

  test "valid name" do
    assert @name.valid?
  end

  test "invalid without title and category" do
    @name.title = nil
    @name.category = nil

    refute @name.valid?

    assert_not_nil @name.errors[:title]
    assert_not_nil @name.errors[:category]
  end

  test "title uniqueness" do
    existing_name = names(:default)
    @name.title = existing_name.title

    refute @name.valid?

    assert_includes @name.errors[:title], "has already been taken"
  end

  # Callbacks

  test "capitalize title before validation" do
    @name.title = "lowerCaseInCamelFormTitle"

    @name.valid?

    assert_equal @name.title, "Lowercaseincamelformtitle"
  end

  test "set capital letter before create" do
    @name.title = "ALetter"
    assert_not @name.capital_letter

    @name.save

    assert @name.capital_letter
    assert_equal @name.capital_letter, "A"
  end

  # Associations

  test "name may belong to origin country" do
    @name.origin_country = origin_countries(:default)

    assert @name.valid?
    assert @name.origin_country
  end

  test "name should not belong to origin country" do
    @name.origin_country = nil

    assert @name.valid?
    assert_not @name.origin_country
  end

  test "create a name wiki" do
    MATCHING_ORIGIN = "Created from Name"

    assert_difference "Wiki.count" do
      @name.build_wiki(origin: MATCHING_ORIGIN, meaning: "Wiki")
      @name.save!
    end
    assert @name.wiki
    assert_equal MATCHING_ORIGIN, @name.wiki.origin
  end

  test "create a name famous people list" do
    MATCHING_FAMOUS_NAME = "Created from Name"

    assert_difference "FamousPeopleList.count" do
      @name.build_famous_people_list(names: [MATCHING_FAMOUS_NAME])
      @name.save!
    end
    assert @name.famous_people_list
    assert_includes @name.famous_people_list.names, MATCHING_FAMOUS_NAME
  end
end
