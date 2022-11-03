class Name < ApplicationRecord
  belongs_to :origin_country, optional: true
  has_one :wiki, dependent: :destroy

  accepts_nested_attributes_for :wiki

  enum category: { male: 0, female: 1}

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def human_category
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{self.category}")
  end
end
