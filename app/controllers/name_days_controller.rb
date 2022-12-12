class NameDaysController < ApplicationController
  add_breadcrumb "Головна", :root_path, only: :index
  add_breadcrumb "Календар Іменин", :name_days_path, only: :index

  def index
    @name_days = NameDay.all
    @name_days = @name_days.by_month(params[:by_month]) if params[:by_month]
  end

  private

  def filter_params
    params.permit(:by_month)
  end
end