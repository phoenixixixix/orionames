class Post < ApplicationRecord
  PHOTO_TOKEN_PATTERN = /\A[A-Za-z0-9+_-]+\z/

  acts_as_taggable_on :tags

  validates :title, presence: true, length: { maximum: 70 }
  validates :body, presence: true, length: { maximum: 30_000 }
  validates :photo_token, format: { with: PHOTO_TOKEN_PATTERN }
end
