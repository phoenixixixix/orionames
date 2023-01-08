class Post < ApplicationRecord
  paginates_per 5

  acts_as_taggable_on :tags

  before_save -> { photo_token.strip! }

  validates :title, presence: true, length: { maximum: 70 }
  validates :body, presence: true, length: { maximum: 30_000 }

  def get_unsplash_photo
    Unsplash::Photo.find(photo_token)
  rescue SocketError, NoMethodError, Unsplash::NotFoundError, Unsplash::Error
    nil
  end
end
