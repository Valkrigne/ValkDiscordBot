module BattleNet
  class << self
    def register(bot)
      wow.each do |m|
        func = Proc.new do |event|
          m.function(event)
        end
        bot.register_event('message', { with_text: m.regex } , func)
      end
    end

    def function(event)

    end

    def path_builder(category, id=nil, realm=nil)
      root = URLS[:BATTLENET][:ROOT]
      path = root + URLS[:BATTLENET][category] + "?#{BOT_ENV[:API][:bnet][:locale]}&apikey=#{BOT_ENV[:API][:bnet][:key]}"
      return path % { query: id, realm: realm }
    end

    def wow
      [
        Character,
        RealmStatus
      ]
    end
  end
end
