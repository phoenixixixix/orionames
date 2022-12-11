class PagesController < ApplicationController
  def main
    @categories = Name.categories.keys
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.all
    
    @selections = Selection.take(2)

    @name_days_months = NameDay.months.keys
    @name_day_today = NameDay.celebration_today
    @name_day_tomorrow = NameDay.celebration_tomorrow

    @posts = Post.last(3)
  end
end