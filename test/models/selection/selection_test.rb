require "test_helper"

class SelectionTest < ActiveSupport::TestCase
  setup do
    # creates hash (name: name_id) to populate names attr in selection
    names = {}
    10.times do  |i|
      name = Name.create!(title: "TestSelectionName_#{i}", category: 0)
      names[name.id] = name.title
    end

    @selection = Selection.new(
      title: "TestSelection",
      names: names
    )
  end

  test "valid selection" do
    assert @selection.valid?
  end

  # Validations

  test "invalid when key in names hash is not in numeric format" do
    @selection.names = { "string" => "invalid" }

    refute @selection.valid?
    assert_includes @selection.errors[:names], I18n.t(:numeric_key_in_names, scope: "activerecord.errors.models.selection.attributes.names")
  end

  test "invalid when names size less than 10" do
    assert_equal 10, @selection.names.size
    element_to_remove = @selection.names.keys.last

    @selection.names.delete(element_to_remove)

    assert_not @selection.valid?
    assert_not_equal 10, @selection.names.size
    assert_includes @selection.errors[:names], I18n.t(:names_exactly_10, scope: "activerecord.errors.models.selection.attributes.names")
  end

  test "invalid when names size more than 10" do
    assert_equal 10, @selection.names.size
    redundant_el = {"1" => "RedundantName"}

    @selection.names.merge!(redundant_el)

    assert_not @selection.valid?
    assert_not_equal 10, @selection.names.size
    assert_includes @selection.errors[:names], I18n.t(:names_exactly_10, scope: "activerecord.errors.models.selection.attributes.names")
  end

  # Methods

  test "ids_to_names_hash method takes ids array and produces id to name hash" do
    name = names(:default)
    @selection.names = [name.id]

    @selection.ids_to_names_hash

    assert @selection.names.is_a? Hash
    assert_includes @selection.names.keys, name.id.to_s
    assert_includes @selection.names.values, name.title
  end
end
