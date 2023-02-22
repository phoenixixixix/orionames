class NameDaysController < ApplicationController
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path, only: :index

  def index
    @name_days = NameDay.by_month(params[:month]).order(:day)
    @name_day_today = NameDay.celebration_today
    @name_day_tomorrow = NameDay.celebration_tomorrow
  end

  private

  def filter_params
    params.permit(:month)
  end
end
