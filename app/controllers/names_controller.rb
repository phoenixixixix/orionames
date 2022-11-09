class NamesController < ApplicationController
  def index
    populate_filters(query_string_params)

    @names_hash = filter_names(Name.all, query_string_params).group_by { |n| n.title.first }

    @categories = Name.categories.keys
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.all
  end

  def show
    @name = Name.find(params[:id])
    @wiki = @name.wiki
  end

  def new
    @name = Name.new
    @name.build_wiki
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
      wiki_attributes: [:origin, :meaning])
  end

  def query_string_params
    params.permit(:origin_country_id, :category)
  end

  def filter_names(names_list, query)
    return names_list if query.empty?

    names_list.select do |name|
      name.fits_to_query(query)
    end
  end
end
