require 'discordrb'

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
		# bot.message(from: "Valkrigne", containing: /(?:bot: )/) do |event|
		# 	if (event.message.author.id == 73056257883254784)
		# 		command = event.message.content.gsub(/^(?:bot: )(.*)/, '\1')
		# 		response = eval(command)
		# 		event.respond(response)
		# 	end
		# end

		bot.message(containing: [/^(?:(?:bot|athena): )/i] ) do |event|
			user = ::User.find_or_create(event.message.author.id, event.message.author.display_name)
			::RecordedMessage.create(user_id: user.id, message: event.message.content.gsub(/^(?:(?:bot|athena): )/i, ''))
		end
	end

	def members
		@members ||= bot.server.members
	end
end
