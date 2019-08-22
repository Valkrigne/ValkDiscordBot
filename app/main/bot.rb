require 'discordrb'

class DiscordBot
	def token
		@token = BOT_ENV[:bot][:BOT_TOKEN]
	end

	def client_id
		@app_id = BOT_ENV[:bot][:CLIENT_ID]
	end

	def channels
		return BOT_ENV[:channels]
	end

	def bot
		@bot ||= Discordrb::Bot.new token: token, client_id: client_id
	end

	def run_bot
		bot.run
	end

	def get_user(author)
		return ::User.find_or_create(author.id, author.display_name)
	end

	def record_message(user_id, message)
		RecordedMessage.create user_id: user_id, message: message
	end

	def register_event(type, trigger, function)
		case type
		when 'message'
			bot.message(trigger) do |event|
				user = get_user(event.message.author)
				record_message(user.id, event.message.content)
				response = run_event(event, &function)
				event.respond(response)
			end
		end
	end

	def run_event(event)
		yield event
	end

	def register_events
		bot.message(with_text: /^(?:(?:bot|athena)\:\s)/i ) do |event|
			user = get_user(event.message.author)
			::RecordedMessage.create(user_id: user.id, message: event.message.content.gsub(/^(?:(?:bot|athena): )/i, ''))
		end

		bot.message(with_text: /^!(btags|battletags)/) do |event|
			user = get_user(event.message.author)
			users = User.where.not(battletag: nil)
			response = ""
			users.map { |u| response += "#{u.name}: #{u.battletag}\n"}
			response.strip!
			event.respond(response)
		end

		bot.message(with_text: /!(?:bot|athena)/i) do |event|
			user = get_user(event.message.author)
			record_message(user.id, event.message.content)
			help_response = "bot/athena: <message> will be recorded\nie: athena: this bot doesnt do anything\n!mh <monster_name> returns kiranico url"
			event.respond(help_response)
		end
	end

	def members
		@members ||= bot.server.members
	end
end
