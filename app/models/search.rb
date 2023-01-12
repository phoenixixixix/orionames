class Search
  def self.perform(query)
    result = {}
    return result if query.size > Name::MAX_NAME_LENGTH

    query = query.capitalize.strip

    result[:name] = Name.find_by(title: query)
    result[:name_days] = NameDay.where("? = ANY(names_list)", query)

    result
  end
end