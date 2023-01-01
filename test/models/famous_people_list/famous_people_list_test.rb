require "test_helper"

class FamousPeopleListTest < ActiveSupport::TestCase
  setup do
    @famous_people_list = FamousPeopleList.new(
      name: names(:default),
      names: %w(Famous Names)
    )
  end

  test "valid FamousPeopleList" do
    assert @famous_people_list.valid?
  end

  test "destroy record on destroying associated name" do
    name = names(:default)
    @famous_people_list.name = name
    @famous_people_list.save

    assert_difference("FamousPeopleList.count", -1) do
      name.destroy
    end
    assert_empty FamousPeopleList.where(id: @famous_people_list.id)
  end
end
