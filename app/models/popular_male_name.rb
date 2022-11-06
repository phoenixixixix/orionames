class PopularMaleName < ApplicationRecord
  after_validation :set_name_title

  validates :name_id, presence: true, uniqueness: true

  validate :exclusively_male_names_and_name_must_exist, on: :create
  validate :max_10_records_limit, on: :create

  def name
    Name.find(name_id)
  end

  private

  def set_name_title
    self.name_title = name.title

    rescue ActiveRecord::RecordNotFound
      errors.add(:base, "Name record must exist")
  end

  def exclusively_male_names_and_name_must_exist
    errors.add(:base, "Must be exclusively Male names") unless name.male?

    rescue ActiveRecord::RecordNotFound
      errors.add(:base, "Name record must exist")
  end

  def max_10_records_limit
    errors.add(:base, "Reached limit of table records") if PopularMaleName.count >= 10
  end
end
