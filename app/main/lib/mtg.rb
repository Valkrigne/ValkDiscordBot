module MTG
  class << self
    def search(query)
      url = URLS[:MTG_SEARCH_URL] + "name=#{query}"
      cards = ApiConnector.get(url)
      return cards['cards']
    end
  end
end
