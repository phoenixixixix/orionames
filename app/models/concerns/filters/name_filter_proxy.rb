module Filters
  module NameFilterScopes
    extend FilterScopeable

    filter_scope :category, ->(category) { where(category: category) }
    filter_scope :origin, ->(origin) { joins(:origin_country).where(origin_country: {title: origin}) }
    filter_scope :letter, ->(letter) { where(capital_letter: letter) }
  end

  class NameFilterProxy < FilterProxy
    def self.query_scope = Name
    def self.filter_scopes_module = Filters::NameFilterScopes
  end
end
