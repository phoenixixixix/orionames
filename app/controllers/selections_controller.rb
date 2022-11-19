class SelectionsController < ApplicationController
  def index
    @selections = Selection.all
  end

  def new
    @selection = Selection.new
  end

  def create
    @selection = Selection.new(selection_params)
    @selection.ids_to_names_hash

    if @selection.save
      redirect_to selections_path
    else
      render "new"
    end
  end

  private

  def selection_params
    params.require(:selection).permit(:title, names: [])
  end
end