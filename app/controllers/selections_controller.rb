class SelectionsController < ApplicationController
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path, only: :index
  add_breadcrumb I18n.t("breadcrumbs.selections"), :selections_path, only: :index
  def index
    @selections = Selection.order(created_at: :desc).page(params[:page])
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
    params.require(:selection).permit(:title, :post_id, :pinned, names: [])
  end
end