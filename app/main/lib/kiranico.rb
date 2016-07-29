module Kiranico
  class << self
    def search(category, query)
      result_arrays = []
      search_index[category]['data'].map{ |m| result_arrays.push m if m['n'].match(/#{query}/i) }

      results = []
      result_arrays.each do |r|
        results.push URLS[:KIRANICO_ROOT_URL] % { category: category, path: r['p'] }
      end
      return results
    end

    def search_monster(query)
      result_arrays = []
      return false if query.length < 4
      search_index['monster']['data'].map{ |m| result_arrays.push m if m['n'].match(/#{query}/i) }

      results = []
      return false if result_arrays.empty?
      result_arrays.each do |r|
        results.push URLS[:KIRANICO_ROOT_URL] % { category: 'monster', path: r['p'] }
      end
      return results
    end

    def search_index
      @index ||= ApiConnector.get(URLS[:KIRANICO_SEARCH_URL])
    end
  end
end
