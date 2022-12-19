class NameDaysController < ApplicationController
  before_action :set_name_day, only: %w(edit update)
  before_action :sanitize_names_list, only: %w(create update)
  add_breadcrumb "Головна", :root_path, only: :index
  add_breadcrumb "Календар Іменин", :name_days_path, only: :index

  def index
    @name_days = NameDay.all
    @name_days = @name_days.by_month(params[:by_month]) if params[:by_month]
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
    params.permit(:by_month)
  end
end
