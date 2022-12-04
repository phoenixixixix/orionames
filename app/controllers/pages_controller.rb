class PagesController < ApplicationController
  def main
    @categories = Name.categories.keys
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.select(:id, :uk_title_plural)
    
    @selections = Selection.take(2)

    @name_days_months = NameDay.months.keys
    @name_day_today = NameDay.celebration_today
    @name_day_tomorrow = NameDay.celebration_tomorrow

    @posts = Post.last(3)
  end
end