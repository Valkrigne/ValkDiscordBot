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
        user = User.find_by(discord_id: event.author.id)
        if user.present?
          stats = Overwatch.player_data(user.battletag)
          return OutputFormatter.overwatch(stats)
        else
          return
        end
      elsif event.message.content.match(/(^!ow$|^!ow\s<help>$|^!ow\s\?$)/)
        return "!ow <battletag> to pull overwatch stats\n!ow set/save <battletag> to set a battletag to your discord account\n!ow s/search <battletag/discord user> to search for other user's battletags"
      elsif event.message.content.match(/!ow\s(?:search|s)\s((?:[a-z]+#[0-9]+)|(?:.*[^#]))/i)
        name = event.message.content.gsub(/!ow\s(?:search|s)\s((?:[a-z]+#[0-9]+)|(?:.*[^#]))/i, '\1')
        response = "searching for #{name}"
        if name.match(/#/)
          user = User.find_by(battletag: name)
          if user.nil?
            user = User.find_by(name: name)
            if user.nil?
              return "#{name} not found"
            end
          end
        else
          user = User.find_by(name: name)
          if user.nil?
            return "#{name} not found"
          end
        end
        stats = Overwatch.player_data(user.battletag)
        return OutputFormatter.overwatch(stats)
      elsif event.message.content.match(/!ow\s(?:set|save)\s([a-z]+#[0-9]+)/i)
        battletag = event.message.content.gsub(/!ow\s(?:set|save)\s([a-z]+#[0-9]+)/i, '\1')
        ::User.find_or_create_battletag(event.author.id, event.author.display_name, battletag)
        return "Saving Battletag: #{battletag} to User: #{event.author.display_name}"
      elsif event.message.content.match(/!ow\s([a-z]+#[0-9]+)/i)
        battletag = event.message.content.gsub(/!ow\s([a-z]+#[0-9]+)/i, '\1')
        ::User.find_or_create(event.author.id, event.author.display_name)
        stats = Overwatch.player_data(battletag)
        return OutputFormatter.overwatch(stats)
      end
    else
      return "!ow <battletag> to pull overwatch stats\n!ow set/save <battletag> to set a battletag to your discord account\n!ow s/search <battletag/discord user> to search for other user's battletags"
    end

    def player_data(playername)
      battletag = playername.gsub(/#/, '-')
      path = URLS[:OVERWATCH_BATTLETAG_GET] % { battletag: battletag }
      page = ApiConnector.nokogiri_get(path)
      name = page.css("div.header-box h1").children.to_s.gsub(/([a-z]#[0-9]+)\s.*/, '\1')
      level = page.css("div.header-avatar span").children.to_s

      hero_stats = page.css("div.stats-list div.stats-list-box")
      stats = [
        get_game_stats(hero_stats, 0),
        get_game_stats(hero_stats, 1),
        get_game_stats(hero_stats, 2),
        get_game_stats(hero_stats, 3),
        get_game_stats(hero_stats, 4),
        get_game_stats(hero_stats, 5)
      ]

      top_hero = page.css("div.data-heroes")
      hero_stats = [
        get_hero_data(top_hero, 0),
        get_hero_data(top_hero, 1),
        get_hero_data(top_hero, 2),
        get_hero_data(top_hero, 3),
        get_hero_data(top_hero, 4)
      ]
      return {
        name: name,
        level: level,
        stats: stats,
        top_heroes: hero_stats
      }
    end

    def get_game_stats(page, index)
      {
        stat: page[index].css("span.stats-label").children.to_s,
        value: page[index].css("strong.stats-value").children.to_s,
        percentile: page[index].css("small.stats-percentile").children[1].children.to_s.capitalize
      }
    end

    def get_hero_data(page, index)
       {
         hero: page.css("div.heroes-details")[index].css("div.heroes-details-card div.card-hero-name strong").children.to_s,
         games_played: page.css("div.heroes-details")[index].css("div.heroes-details-card div.card-hero-name span").children.to_s,
         playtime: page.css("div.heroes-details")[index].css("div.heroes-details-card div.card-primary-stats span.stat-playtime").children[0].to_s,
         winrate: page.css("div.heroes-details")[index].css("div.heroes-details-card div.card-primary-stats div.card-primary-stat")[3].css("strong span").children.to_s
       }
    end
  end
end
