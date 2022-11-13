class NamesController < ApplicationController
  def index
    @curr_category, @curr_letter, @curr_origin = filter_params[:category],
                                                 filter_params[:letter],
                                                 filter_params[:origin]

    @names_hash = filtered_names(Name.all, filter_params).group_by { |n| n.title.first }

    @categories = Name.categories.keys
    @alphabet = Name::UK_LETTERS_LIST
    @origin_countries = OriginCountry.select(:id, :uk_title_plural)
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

  def filter_params
    params.permit(:category, :letter, :origin)
  end

  def filtered_names(names, filters)
    return names if filters.empty?

    names.apply_filters(filters)
  end
end
