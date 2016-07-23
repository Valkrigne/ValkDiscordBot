require 'discordrb'

class DiscordBot
	def token
		@token = BOT_ENV[:bot][:token]
	end

	def app_id
		@app_id = BOT_ENV[:bot][:app_id]
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

	def register_events
		# bot.message(from: "Valkrigne", containing: /(?:bot: )/) do |event|
		# 	if (event.message.author.id == 73056257883254784)
		# 		command = event.message.content.gsub(/^(?:bot: )(.*)/, '\1')
		# 		response = eval(command)
		# 		event.respond(response)
		# 	end
		# end

		bot.message(with_text: /^(?:(?:bot|athena)\:\s)/i ) do |event|
			user = get_user(event.message.author)
			::RecordedMessage.create(user_id: user.id, message: event.message.content.gsub(/^(?:(?:bot|athena): )/i, ''))
		end

		bot.message(with_text: /!(?:bot|athena)/i) do |event|
			user = get_user(event.message.author)
			help_response = "bot/athena: <message> will be recorded\nie: athena: this bot doesnt do shit"
			event.respond(help_response)
		end

		# MH matchers
		# bot.message(with_text: /!mh\s\w+\s.*/i) do |event|
		# 	results = 'placeholder'
		# 	event.message.content.gsub(/(?:!mh\s)(\w+)\s(.*)/) do
		# 		results = Kiranico.search($1, $2).join("\n")
		# 	end
		# 	event.respond(results)
		# end

		bot.message(with_text: /!mh\s(.*)/i) do |event|
			results = 'placeholder'
			event.message.content.gsub(/(?:!mh\s)(.*)/) do
				results = Kiranico.search_monster($1).join("\n")
			end
			event.respond(results)
		end
	end

	def members
		@members ||= bot.server.members
	end
end
