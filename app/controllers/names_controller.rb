class NamesController < ApplicationController
  def index
    @names = filtered_names(Name.all, filter_params)
    @names_hash = @names.group_by(&:capital_letter).sort_by { |letter, _| letter }.to_h

    @categories = Name.categories.keys
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.select(:id, :uk_title_plural)

    @applied_filters = filter_params
    @selected_oc_title = @origin_countries.find(filter_params[:by_origin]).uk_title_plural if filter_params[:by_origin]
  end

  def show
    @name = Name.find(params[:id])
    @wiki = @name.wiki
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

  private

  def name_params
    params.require(:name).permit(:title, :category, :origin_country_id, 
      wiki_attributes: [:origin, :meaning], famous_people_list_attributes: [names: []])
  end

  def filter_params
    params.permit(:by_category, :by_letter, :by_origin)
  end

  def filtered_names(names, filters)
    return names if filters.empty?

    names.apply_filters(filters)
  end
end
