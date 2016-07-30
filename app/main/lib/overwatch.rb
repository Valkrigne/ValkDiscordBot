module Overwatch
  REGEX = /^!ow.*/i

  class << self
    def register(bot)
      func = Proc.new do |event|
        Overwatch.function(event)
      end
      bot.register_event('message', { with_text: Overwatch::REGEX }, func)
    end

    def function(event)
      if event.message.content == '!ow'
        return "!ow <battletag> to pull overwatch stats"
      elsif event.message.content.match(/!ow\s([a-z]+#[0-9]+)/i)
        battletag = event.message.content.gsub(/!ow\s([a-z]+#[0-9]+)/i, '\1').gsub(/#/, '-')
        puts battletag
        if true #overbuff doesnt respond to HEAD call Overwatch.check_battletag(battletag) ||
          stats = Overwatch.get_player_data(battletag)
          return "Name: #{stats[0]}\nLevel: #{stats[1]}\nStats By Role: #{stats[2]}\nTop Heroes: #{stats[3]}"
        else
          return "Battletag not found"
        end
      end
    end

    def check_battletag(battletag)
      url = URLS[:BATTLE_TAG_CHECK] % { battletag: battletag }
      puts url
      response = ApiConnector.head(url)
      if response.code >= 400
        return false
      elsif response.code == 200
        return true
      else
        return false
      end
    end

    def get_player_data(playername)
      battletag = playername.gsub(/#/, '-')
      path = URLS[:BATTLE_TAG_CHECK] % { battletag: battletag }
      if battletag.gsub(/-[0-9]/, '').length == 0
        return false
      end

      page = ApiConnector.nokogiri_get(path)

      page
      header = page.css('div.image-with-corner').children[0]
      name = page.css('div.image-with-corner').children[0].to_s.gsub(/.*alt=\"(\w+)\".*/, '\1')
      level = page.css('div.image-with-corner').children[1].children.to_s

      stats = page.css('div.layout-header-secondary')
      on_fire =  page.css('div.layout-header-secondary').children[0].children.children[0].to_s
      games_won = page.css('div.layout-header-secondary').children[1].children.children.children[0].children.to_s.to_i
      games_lost = page.css('div.layout-header-secondary').children[1].children.children.children[2].children.to_s.to_i
      win_rate = page.css('div.layout-header-secondary').children[2].children.children[0].to_s.to_f

      roles = page.css('div[data-portable=roles]')
      roles = [
        get_role_data(page, 0),
        get_role_data(page, 1),
        get_role_data(page, 2),
        get_role_data(page, 3)
      ]

      top_heroes = [
        get_hero_data(page, 0),
        get_hero_data(page, 1),
        get_hero_data(page, 2),
        get_hero_data(page, 3),
        get_hero_data(page, 4)
      ]
      return [name, level, roles, top_heroes]
    end

    def get_role_data(page, index)
      {
        name: page.css('div[data-portable=roles] section article table tbody tr')[index].children[1].children.children.children[0].to_s,
        games_played: page.css('div[data-portable=roles] section article table tbody tr')[index].children[2].children[0].to_s,
        win_rate: page.css('div[data-portable=roles] section article table tbody tr')[index].children[3].children[0].to_s
      }
    end

    def get_hero_data(page, index)
       {
         name: page.css('div.player-hero')[index].children.children.children[1].children.children[0].to_s,
         wins: page.css('div.player-hero')[index].children.children.children[4].children.children.children[0],
         losses: page.css('div.player-hero')[index].children.children.children[4].children.children.children[2]
       }
    end
  end
end
