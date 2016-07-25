require 'rest-client'
require 'nokogiri'
require 'json'

module ApiConnector
  class << self
    def get(path)
      response = RestClient.get path
      return JSON.parse(response.to_s)
    end

    def head(path)
      response = RestClient.head path
      return JSON.parse(response.to_s)
    end

    def nokogiri_get(path)
      return Nokogiri::HTML(RestClient.get(path))
    end
  end
end
