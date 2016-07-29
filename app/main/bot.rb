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

	def register_events
		bot.message(with_text: /^(?:(?:bot|athena)\:\s)/i ) do |event|
			user = get_user(event.message.author)
			::RecordedMessage.create(user_id: user.id, message: event.message.content.gsub(/^(?:(?:bot|athena): )/i, ''))
		end

		bot.message(with_text: /!(?:bot|athena)/i) do |event|
			user = get_user(event.message.author)
			help_response = "bot/athena: <message> will be recorded\nie: athena: this bot doesnt do shiti\n!mh <monster_name> retunrs kiranico url"
			event.respond(help_response)
		end

		bot.message(with_text: /!mh\s(.*)/i) do |event|
			results = 'placeholder'
			event.message.content.gsub(/(?:!mh\s)(.*)/) do
				results = Kiranico.search_monster($1)
			end
    	 if results == false
				results = 'nothing found'
			else
				results = results.join("\n")
			end
			event.respond(results)
		end

		bot.message(with_text: /!ow/) do |event|
			if event.message.content == '!ow'
				event.respond("!ow <battletag> to pull overwatch stats")
			elsif event.message.content.match(/!ow\s([a-z]+#[0-9]+)/)
				battletag = event.message.content.gsub(/!ow\s([a-z]+#[0-9]+)/, '\1')
				user = get_user(event.message.author)
				if Overwatch.check_battletag(battletag)
					stats = Overwatch.get_player_data(battletag)
					response = "Name: #{stats[0]}\nLevel: #{stats[1]}\nStats By Role: #{stats[2]}\nTop Heroes: #{stats[3]}"
				else
					event.respond("Battletag not found")
				end
				event.respond(response)
			end
		end
	end

	def members
		@members ||= bot.server.members
	end
end
