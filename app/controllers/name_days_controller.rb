class NameDaysController < ApplicationController
  def index
    @name_days = NameDay.all
    @name_days = @name_days.by_month(params[:by_month]) if params[:by_month]
  end

  private

  def filter_params
    params.permit(:by_month)
  end
end