class SelectionsController < ApplicationController
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path, only: :index
  add_breadcrumb I18n.t("breadcrumbs.selections"), :selections_path, only: :index
  def index
    @selections = Selection.order(created_at: :desc).page(params[:page])
  end

  private

  def selection_params
    params.require(:selection).permit(:title, :post_id, :pinned, names: [])
  end
end