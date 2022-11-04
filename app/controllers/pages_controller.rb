class PagesController < ApplicationController
  def main
    @origin_countries = OriginCountry.all
    @categories = Name.categories.keys
  end
end