class SitemapsController < ApplicationController
  layout :false
  before_action :init_sitemap

  def index
    @names = Name.all
    @name_days_months = NameDay.months.keys
    @posts = Post.all
  end

  private

  def init_sitemap
    headers["Content-Type"] = "application/xml"
  end
end
