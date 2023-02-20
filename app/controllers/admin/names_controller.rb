class Admin::NamesController < Admin::AdminController
  before_action :set_name, only: %i[edit update destroy]

  def index
    @names = Name.all
    @names = @names.order_by_capital_letter.page(params[:page])
  end

  def new
    @name = Name.new
    @name.build_wiki
    @name.build_famous_people_list
  end

  def create
    @name = Name.new(name_params)

    if @name.save
      redirect_to admin_names_path, notice: "Name was successfully created."
    else
      render "new"
    end
  end

  def edit
    @name.wiki
    @name.famous_people_list ? @name.famous_people_list : @name.build_famous_people_list
  end

  def update
    if @name.update(name_params)
      redirect_to @name
    else
      render "edit"
    end
  end

  def destroy
    @name.destroy
    redirect_to admin_names_path, notice: "Name was successfully destroyed."
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
