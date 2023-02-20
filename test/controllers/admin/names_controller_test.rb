require "test_helper"

class Admin::NamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_name = admin_names(:one)
  end

  test "should get index" do
    get admin_names_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_name_url
    assert_response :success
  end

  test "should create admin_name" do
    assert_difference("Admin::Name.count") do
      post admin_names_url, params: { admin_name: {  } }
    end

    assert_redirected_to admin_name_url(Admin::Name.last)
  end

  test "should show admin_name" do
    get admin_name_url(@admin_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_name_url(@admin_name)
    assert_response :success
  end

  test "should update admin_name" do
    patch admin_name_url(@admin_name), params: { admin_name: {  } }
    assert_redirected_to admin_name_url(@admin_name)
  end

  test "should destroy admin_name" do
    assert_difference("Admin::Name.count", -1) do
      delete admin_name_url(@admin_name)
    end

    assert_redirected_to admin_names_url
  end
end
