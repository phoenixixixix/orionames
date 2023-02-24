class Admin::NameDaysController < Admin::AdminController
  before_action :set_name_day, only: %i[edit update destroy]
  before_action :sanitize_names_list, only: %i[create update]

  def index
    @name_days = NameDay.by_month(params[:month]).order(:day)
  end

  def new
    @name_day = NameDay.new
  end

  def create
    @name_day = NameDay.new(name_day_params)
    if @name_day.save
      redirect_to admin_name_days_path, notice: "Name day was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @name_day.update(name_day_params)
      redirect_to admin_name_days_path, notice: "Name day was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @name_day.destroy
    redirect_to admin_name_days_url, notice: "Name day was successfully destroyed."
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
