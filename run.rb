require './app/options.rb'
require File.expand_path('../app/config/environment/production.rb', __FILE__)

options = option_parse

# check dependencies
if GemCheck.check_gem_library(false)
  # run bot
  run_bot
else
  p "required dependencies not found, run bundler"
end
