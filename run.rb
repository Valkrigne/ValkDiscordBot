#!/usr/bin/env ruby
`echo $! > /tmp/discord_bot.pid`
require File.expand_path('../app/config/environment/production.rb', __FILE__)
@bot.run_bot
