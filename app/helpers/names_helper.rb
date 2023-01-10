module NamesHelper
  def link_to_with_filter_multiplier(param_key, param_value, **html_options)
    # except :page parameter to avoid pages without names
    if param_key.to_s == "by_category"
      link_to Name.human_enum_name(param_key, param_value),
              request.params.merge("#{param_key}" => param_value).except(:page),
              class: html_options[:class]
    else
      link_to param_value, request.params.merge("#{param_key}" => param_value).except(:page), class: html_options[:class]
    end
  end

  def build_heading_from_filters(filters)
    category, origin, letter = filters[:by_category], filters[:by_origin], filters[:by_letter]

    out = "#{origin} #{category} #{t("names.index.heading.names")} #{t("names.index.heading.with_letter") + " " + letter if letter}"
    out.strip!
    out.capitalize!

    out.html_safe
  end
end
