class ErrorsController < ApplicationController
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path

  def not_found
    add_breadcrumb I18n.t("breadcrumbs.404_page")
    render status: 404
  end

  def unacceptable
    add_breadcrumb I18n.t("breadcrumbs.422_page")
    render status: 422
  end

  def internal_server_error
    add_breadcrumb I18n.t("breadcrumbs.500_page")
    render status: 500
  end
end
