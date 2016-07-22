require 'rest-client'
require 'json'

module ApiConnector
  class << self
    def get(path)
      response = RestClient.get path
      return JSON.parse(response.to_s)
    end
  end
end
