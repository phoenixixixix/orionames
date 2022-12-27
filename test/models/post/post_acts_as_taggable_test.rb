require "test_helper"

class PostActsAsTaggableTest < ActiveSupport::TestCase
  setup do
    @post = Post.new(title: "PostTagsTest", body: "PostTagsTest body")
  end

  test "add tags to post" do
    tag = "added_tag"
    @post.tag_list = [tag]

    @post.save!

    assert_includes @post.reload.tag_list, tag
    assert_includes Post.all_tags.pluck(:name), tag
  end

  test "multiple tag records for tags separated by coma" do
    assert_empty @post.tag_list

    tag_1, tag_2 = "tag_1", "tag_2"
    coma = "#{tag_1}, #{tag_2}"
    @post.tag_list = [coma]
    @post.save!

    assert_includes @post.tag_list, tag_1
    assert_includes @post.tag_list, tag_2
    assert_not_includes @post.tag_list, coma
    assert_not_includes Post.all_tags.pluck(:name), coma
  end

  test "multiple tag records for tags separated by white space" do
    assert_empty @post.tag_list

    tag_1, tag_2 = "tag_1", "tag_2"
    white_space = "#{tag_1} #{tag_2}"
    @post.tag_list = [white_space]
    @post.save!

    assert_includes @post.tag_list, tag_1
    assert_includes @post.tag_list, tag_2
    assert_not_includes @post.tag_list, white_space
    assert_not_includes Post.all_tags.pluck(:name), white_space
  end
end