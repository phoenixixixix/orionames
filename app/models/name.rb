class Name < ApplicationRecord
  enum category: { male: 0, female: 1}

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def human_category
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{self.category}")
  end
end
