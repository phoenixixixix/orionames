class Search
  def self.perform(query)
    result = {}
    return result if query.size > Name::MAX_NAME_LENGTH

    query = sanitize_query_format(query)

    result[:name] = Name.find_by(title: query)
    result[:name_days] = NameDay.where("? = ANY(names_list)", query)

    result
  end

  private

  def sanitize_query_format(query)
    query.capitalize.strip
  end
end