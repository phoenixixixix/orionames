require "./lib/letters"

class Name < ApplicationRecord
  include Letters
  MAX_NAME_LENGTH = 25

  paginates_per 100

  belongs_to :origin_country, optional: true
  has_one :wiki, dependent: :destroy
  has_one :famous_people_list, dependent: :destroy

  accepts_nested_attributes_for :wiki
  accepts_nested_attributes_for :famous_people_list

  enum category: { male: 0, female: 1}

  before_validation -> { title.capitalize! }, if: :title
  before_save :set_capital_letter

  validates :title, presence: true, uniqueness: true, length: { maximum: MAX_NAME_LENGTH }
  validates :category, presence: true

  scope :by_category, ->(category) { where(category: category) }
  scope :by_origin, ->(origin) { joins(:origin_country).where(origin_country: {title: origin}) }
  scope :by_letter, ->(letter) { where(capital_letter: letter) }

  # The below scope is designed to provide the correct order of letters in a specific alphabet.
  # The issue I'm targeting: the ordinal number of some letters ("і", "є" in Ukrainian) does not correspond to the actual place index in the alphabet.
  # The way the chars are placed in LETTERS_LIST's corresponds to a specific alphabet
  scope :order_by_capital_letter, -> {
    order_clause = "CASE capital_letter "
    LETTERS_LIST.each_with_index do |letter, i|
      order_clause << sanitize_sql_array(["WHEN ? THEN ? ", letter, i])
    end

    order_clause << sanitize_sql_array(["ELSE ? END", LETTERS_LIST.length])
    order(Arel.sql(order_clause))
  }

  def self.apply_filters(filters_hash)
    names = self
    filters_hash.each { |by_filter, value| names = names.public_send(by_filter, value) }

    names
  end

  def similar_names
    Name.where(capital_letter: capital_letter, category: category).limit(5) - [self]
  end

  private

  def set_capital_letter
    self.capital_letter = title.first
  end
end
