class SearchController < ApplicationController
  def index
    @search_response = Search.perform(query_param[:query])
  end

  private

  def query_param
    params.permit(:query)
  end
end
