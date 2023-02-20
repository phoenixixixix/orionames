class Admin::NamesController < Admin::AdminController
  before_action :set_name, only: %i[ show edit update destroy ]

  def index
    @names = Name.all
  end

  def show
  end

  def new
    @admin_name = Name.new
  end

  def edit
  end

  def create
    @name = Name.new(name_params)

    if @name.save
      redirect_to admin_root_path, notice: "Name was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @name.update(name_params)
      redirect_to admin_root_path, notice: "Name was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @name.destroy
    redirect_to admin_names_url, notice: "Name was successfully destroyed."
  end

  private

    def set_name
      @name = Name.find(params[:id])
    end

    def name_params
      params.require(:name).permit(:title, :category, :origin_country_id,
                                   wiki_attributes: [:origin, :meaning, :id],
                                   famous_people_list_attributes: [:id, names: []])
    end
end
