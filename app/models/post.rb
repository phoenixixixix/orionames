class Post < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: [:slugged, :simple_i18n]
  paginates_per 5
  acts_as_taggable_on :tags

  before_validation :set_slug_to_nil, if: :title_changed?
  before_save -> { photo_token.strip! }

  validates :title, presence: true, length: { maximum: 70 }
  validates :body, presence: true, length: { maximum: 30_000 }

  def get_unsplash_photo
    Unsplash::Photo.find(photo_token)
  rescue SocketError, NoMethodError, Unsplash::NotFoundError, Unsplash::Error
    nil
  end

  def next_post
    Post.where("id < ?", id).order(id: :desc).first || Post.order(created_at: :desc).first
  end

  private

  def set_slug_to_nil
    self.slug_en = nil
    self.slug_uk = nil
  end
end
