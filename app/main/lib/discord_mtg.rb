require 'mtg_sdk'

module DiscordMTG

  REGEX = /\[\[(.*)\]\]/

  class << self
    def register(bot)
      func = Proc.new do |event|
        DiscordMTG.function(event)
      end
      bot.register_event('message', { with_text: DiscordMTG::REGEX } , func)
    end

    def function(event)
      query = event.message.content.gsub(DiscordMTG::REGEX, '\1')
      puts query
      MTG::Card.where(name: query)
    end
  end
end
