module NamesHelper
  def build_heading_from_filters(filters)
    category, letter = filters[:by_category], filters[:by_letter]

    out = "#{@selected_oc_title} #{category} імена #{"на букву " + letter if letter}"
    out.strip!
    out.capitalize!

    out.html_safe
  end
end
