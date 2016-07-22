require_relative './api_connector'

module MTG
  class << self
    def search(query)
      url = "https://api.magicthegathering.io/v1/cards?name=" + query
      cards = ApiConnector.get(url)
      return cards['cards']
    end
  end
end
