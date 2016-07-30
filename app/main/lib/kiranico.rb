module Kiranico
  REGEX = /test!mh\s(.*)/i

  class << self
    def register(bot)
      func = Proc.new { Kiranico.function(event) }
      bot.register_event('message', { with_text: Kiranico::REGEX } , func)
    end

    def function(event)
      results = 'placeholder'
      event.message.content.gsub(/(?:test!mh\s)(.*)/) do
        results = Kiranico.search_monster($1)
      end
       if results == false
        results = 'nothing found'
      else
        results = results.join("\n")
      end
      return results
    end

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
