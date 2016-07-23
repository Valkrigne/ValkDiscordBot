require './options.rb'
require File.expand_path('../config/environment.rb', __FILE__)

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
if GemCheck.check_gem_library(false)
  # run bot
  run_bot
else
  p "required dependencies not found, run boot.rb -i"
end
