class Admin::OriginCountriesController < Admin::AdminController
  def new
    @origin_country = OriginCountry.new
  end

  def create
    @origin_country = OriginCountry.new(origin_country_params)

    if @origin_country.save
      redirect_to admin_names_path, notice: "Origin country was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def origin_country_params
    params.require(:origin_country).permit(:title)
  end
end
