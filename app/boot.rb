require './options.rb'
require './config/gem_check.rb'
require './config/gem_install.rb'
require './config/bot_install.rb'
require './initializer.rb'
require './main/main.rb'

options = option_parse

if options[:check]
  GemCheck.check_gem_library(true)
  exit
end

if options[:install]
  BotInstall.install
  exit
end

# check dependencies
GemCheck.check_gem_library(false)

# run initializers
initialize_environment

# run bot
run_bot
