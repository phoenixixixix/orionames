module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :underline, :highlight,
               :no_images, :filter_html, :safe_links_only, :prettify, :no_styles]
    Markdown.new(text, *options).to_html.html_safe
  end

  def get_unsplash_photo(token)
    return if token.present?

    begin
      Unsplash::Photo.find(token)
    rescue SocketError, NoMethodError, Unsplash::NotFoundError, Unsplash::Error
      nil
    end
  end

  def icon(style, title)
    "<i class=\"#{style} #{title}\"></i>".html_safe
  end
end
