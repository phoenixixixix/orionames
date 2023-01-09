class NameDaysController < ApplicationController
  before_action :set_name_day, only: %w(edit update)
  before_action :sanitize_names_list, only: %w(create update)
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path, only: :index
  add_breadcrumb I18n.t("breadcrumbs.name_days")

  def index
    @name_days = NameDay.by_month(params[:month]).order(:day)
  end

  def new
    @name_day = NameDay.new
  end

  def create
    @name_day = NameDay.new(name_day_params)
    if @name_day.save
      redirect_to name_days_path
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @name_day.update(name_day_params)
      redirect_to name_days_path
    else
      render "edit"
    end
  end

  private

  def set_name_day
    @name_day = NameDay.find(params[:id])
  end

  def name_day_params
    params.require(:name_day).permit(:day, :month, names_list: [])
  end

  def sanitize_names_list
    params[:name_day][:names_list] = params[:name_day][:names_list].split(", ")
  end

  def filter_params
    params.permit(:month)
  end
end
