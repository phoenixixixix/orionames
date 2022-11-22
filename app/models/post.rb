class Post < ApplicationRecord
  acts_as_taggable_on :tags

  validates :title, presence: true, length: { maximum: 70 }
  validates :body, presence: true, length: { maximum: 30_000 }
end
