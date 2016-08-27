def run_bot
  @bot = DiscordBot.new
  @bot.register_events
  Kiranico.register(@bot)
  Overwatch.register(@bot)
  DiscordMTG.register(@bot)
  BattleNet.register(@bot)
  @bot.run_bot
end
