# check dependencies
require './config/dependency_check.rb'

#run initializers
require './initializer.rb'

#run main
BOT.run_bot
