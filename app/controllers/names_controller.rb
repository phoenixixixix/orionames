class NamesController < ApplicationController
  before_action :set_name, only: :show
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

  private

  def set_name
    @name = Name.find(params[:id])
  end

  def filter_params
    params.permit(:by_category, :by_letter, :by_origin)
  end

  def filtered_names(names, filters)
    return names if filters.empty?

    names.apply_filters(filters)
  end
end
