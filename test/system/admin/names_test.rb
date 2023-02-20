require "application_system_test_case"

class Admin::NamesTest < ApplicationSystemTestCase
  setup do
    @admin_name = admin_names(:one)
  end

  test "visiting the index" do
    visit admin_names_url
    assert_selector "h1", text: "Names"
  end

  test "should create name" do
    visit admin_names_url
    click_on "New name"

    click_on "Create Name"

    assert_text "Name was successfully created"
    click_on "Back"
  end

  test "should update Name" do
    visit admin_name_url(@admin_name)
    click_on "Edit this name", match: :first

    click_on "Update Name"

    assert_text "Name was successfully updated"
    click_on "Back"
  end

  test "should destroy Name" do
    visit admin_name_url(@admin_name)
    click_on "Destroy this name", match: :first

    assert_text "Name was successfully destroyed"
  end
end
