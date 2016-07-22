module MTG
  API_ADDRESS = 'https://api.magicthegathering.io/v1/cards?'

  class << self
    def search(query)
      url = API_ADDRESS + "name=#{query}"
      cards = ApiConnector.get(url)
      return cards['cards']
    end
  end
end
