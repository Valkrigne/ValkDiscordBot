require 'discordrb'

class DiscordBot
	def token
		@token = 'MjA0MTkxNzI3OTc0NzQ0MDY1.Cmz33Q.gTitaYpM_ud4WcUfO8MwE6YnlGs'
	end

	def app_id
		@app_id = 204191727974744065
	end

	def channels
		return BOT_ENV[:channels]
	end

	def bot
		@bot ||= Discordrb::Bot.new token: token, application_id: app_id
	end

	def run_bot
		bot.run
	end

	def get_user(author)
		return ::User.find_or_create(author.id, author.display_name)
	end

	def register_event(type, trigger, function)
		case type
		when 'message'
			bot.message(trigger) do |event|
				puts 'trigger'
				get_user(event.message.author)
				response = run_event(event, &function)
				puts response
				event.respond(response)
			end
		end
	end

	def run_event(event)
		yield event
	end

	def register_events
		bot.message(with_text: /^(?:(?:bot|athena)\:\s)/i ) do |event|
			puts 'trigger'
			user = get_user(event.message.author)
			::RecordedMessage.create(user_id: user.id, message: event.message.content.gsub(/^(?:(?:bot|athena): )/i, ''))
		end

		bot.message(with_text: /!(?:bot|athena)/i) do |event|
			puts 'trigger'
			user = get_user(event.message.author)
			help_response = "bot/athena: <message> will be recorded\nie: athena: this bot doesnt do shiti\n!mh <monster_name> retunrs kiranico url"
			event.respond(help_response)
		end
	end

	def members
		@members ||= bot.server.members
	end
end
