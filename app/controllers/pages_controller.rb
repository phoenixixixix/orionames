class PagesController < ApplicationController
  def main
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.all
    @categories = Name.categories.keys
    @popular_male_names = PopularMaleName.all
    @popular_female_names = PopularFemaleName.all
  end
end