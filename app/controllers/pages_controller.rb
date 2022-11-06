class PagesController < ApplicationController
  def main
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.all
    @categories = Name.categories.keys
  end
end