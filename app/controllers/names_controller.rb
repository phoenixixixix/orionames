class NamesController < ApplicationController
  before_action :set_name, only: %w(show edit update)
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path, only: %w(index show)
  add_breadcrumb I18n.t("breadcrumbs.names_list"), :names_path, only: %w(index show)

  def index
    @names = filtered_names(Name.all, filter_params)
    @names = @names.order_by_capital_letter.page(params[:page])

    @categories = Name.categories.keys
    @alphabet = Name::LETTERS_LIST
    @origin_titles = OriginCountry.pluck(:title)

    @applied_filters = filter_params
  end

  def show
    @wiki = @name.wiki
    @famous_names = @name.famous_people_list&.names

    add_breadcrumb @name.title, name_path(@name)
  end

  def new
    @name = Name.new
    @name.build_wiki
    @name.build_famous_people_list
  end

  def create
    @name = Name.new(name_params)
    if @name.save
      redirect_to names_path
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

  private

  def set_name
    @name = Name.find(params[:id])
  end

  def name_params
    params.require(:name).permit(:title, :category, :origin_country_id, 
      wiki_attributes: [:origin, :meaning, :id], famous_people_list_attributes: [:id, names: []])
  end

  def filter_params
    params.permit(:by_category, :by_letter, :by_origin)
  end

  def filtered_names(names, filters)
    return names if filters.empty?

    names.apply_filters(filters)
  end
end
