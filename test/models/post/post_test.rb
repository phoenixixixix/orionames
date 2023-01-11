require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @post = Post.new(title: "PostTest", body: "PostTest body")
  end

  test "valid post" do
    assert @post.valid?
  end

  # Validations

  test "invalid without title or body" do
    @post.title = nil
    @post.body = nil

    refute @post.valid?

    assert_not_empty @post.errors[:title]
    assert_not_empty @post.errors[:body]
  end

  test "when title is more 70 chars long" do
    @post.title << "c" * 71

    refute @post.valid?

    assert_not_empty @post.errors[:title]
  end

  test "when body is more 30_000 chars long" do
    @post.body << "c" * 30_001

    refute @post.valid?

    assert_not_empty @post.errors[:body]
  end

  # Callbacks

  test "strip Unsplash photo token before save post" do
    start_end_white_spaces = "     Spaces     "
    @post.photo_token = start_end_white_spaces

    @post.save!

    assert_not_equal @post.photo_token, start_end_white_spaces
    assert_equal @post.photo_token, "Spaces"
  end
end
