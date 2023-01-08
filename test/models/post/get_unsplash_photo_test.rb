require "test_helper"

class GetUnsplashPhotoTest < ActiveSupport::TestCase
  setup do
    @post = Post.new(title: "PostTest", body: "PostTest body")
  end

  test "find unsplash with valid photo token" do
    @post.photo_token = "6Pce32oZYuc"

    assert_not_nil @post.get_unsplash_photo
  end

  test "return nil when photo token is not existing" do
    @post.photo_token = "something_stupid"

    assert_nil @post.get_unsplash_photo
  end

  test "return nil when photo token is nil" do
    @post.photo_token = nil

    assert_nil @post.get_unsplash_photo
  end
end