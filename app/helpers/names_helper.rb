module NamesHelper
  def build_heading_from_filters(filters)
    category, origin, letter = filters[:by_category], filters[:by_origin], filters[:by_letter]

    out = "#{origin} #{category} імена #{"на букву " + letter if letter}"
    out.strip!
    out.capitalize!

    out.html_safe
  end
end
