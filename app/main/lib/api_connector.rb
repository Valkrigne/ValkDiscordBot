require 'rest-client'
require 'nokogiri'
require 'json'

module ApiConnector
  class << self
    def get(path)
      begin
        response = RestClient.get path
        return JSON.parse(response.to_s)
      rescue => e
        return e.response
      end
    end

    def head(path)
      begin
        response = RestClient.head path
        return JSON.parse(response.to_s)
      rescue => e
        return e.response
      end
    end

    def nokogiri_get(path)
      response = RestClient.get(path)
      return response if response.code >= 400
      return Nokogiri::HTML(response)
    end
  end
end
