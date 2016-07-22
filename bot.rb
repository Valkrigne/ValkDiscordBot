require 'discordrb'
require_relative './mtg'

class DiscordBot
	def initialize(*args)
		@token = 'MjA0MTkxNzI3OTc0NzQ0MDY1.Cmz33Q.gTitaYpM_ud4WcUfO8MwE6YnlGs'
		@app_id = 204191727974744065
	end

	def channels
		return 204366501300535307 # bot room
	end

	def bot
		@bot ||= Discordrb::Bot.new token: @token, application_id: @app_id
	end

	def run_bot
		bot.run
	end

	def register_events
		bot.message(from: "Valkrigne", containing: /(?:bot: )/) do |event|
			if (event.message.author.id == 73056257883254784)
				command = event.message.content.gsub(/^(?:bot: )(.*)/, '\1')
				response = eval(command)
				event.respond(response)
			end
		end

		bot.message(containing: "genji") do |event|
			event.respond(old_name + " renamed to GenjiScum, maybe..." )
		end
	end

	def members
		@members ||= bot.server.members
	end
end

bot = DiscordBot.new
bot.register_events
bot.run_bot
