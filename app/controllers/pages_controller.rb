class PagesController < ApplicationController
  def main
    @categories = Name.categories.keys
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.select(:id, :uk_title_plural)
    
    @popular_male_names = PopularMaleName.all
    @popular_female_names = PopularFemaleName.all

    @name_days_months = NameDay.months.keys
    @name_day_today = NameDay.celebration_today
    @name_day_tomorrow = NameDay.celebration_tomorrow
  end
end