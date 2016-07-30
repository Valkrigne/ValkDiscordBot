module OutputFormatter
  class << self
    def string_padder(string, cap)
      padding = ""
      (cap - string.length).times do
        padding += " "
      end
      return padding
    end

    def overwatch(stats)
      "Name: #{stats[:name]}
Level: #{stats[:level]}
Stats per 5 minutes of gametime:```
#{stats[:stats][0][:stat] + string_padder(stats[:stats][0][:stat], 12)}: #{stats[:stats][0][:value]}, #{stats[:stats][0][:percentile]}
#{stats[:stats][1][:stat] + string_padder(stats[:stats][1][:stat], 12)}: #{stats[:stats][1][:value]}, #{stats[:stats][1][:percentile]}
#{stats[:stats][2][:stat] + string_padder(stats[:stats][2][:stat], 12)}: #{stats[:stats][2][:value]}, #{stats[:stats][2][:percentile]}\n```
Top Heroes:```
#{stats[:top_heroes][0][:hero] + ":" + string_padder(stats[:top_heroes][0][:hero], 12)} #{stats[:top_heroes][0][:games_played]} played, #{string_padder(stats[:top_heroes][0][:games_played].to_s, 10)}\t#{stats[:top_heroes][0][:playtime]} played,#{string_padder(stats[:top_heroes][0][:playtime].to_s, 9)}\t#{stats[:top_heroes][0][:winrate]} winrate
#{stats[:top_heroes][1][:hero] + ":" + string_padder(stats[:top_heroes][1][:hero], 12)} #{stats[:top_heroes][1][:games_played]} played, #{string_padder(stats[:top_heroes][1][:games_played].to_s, 10)}\t#{stats[:top_heroes][1][:playtime]} played,#{string_padder(stats[:top_heroes][1][:playtime].to_s, 9)}\t#{stats[:top_heroes][1][:winrate]} winrate
#{stats[:top_heroes][2][:hero] + ":" + string_padder(stats[:top_heroes][2][:hero], 12)} #{stats[:top_heroes][2][:games_played]} played, #{string_padder(stats[:top_heroes][2][:games_played].to_s, 10)}\t#{stats[:top_heroes][2][:playtime]} played,#{string_padder(stats[:top_heroes][2][:playtime].to_s, 9)}\t#{stats[:top_heroes][2][:winrate]} winrate
#{stats[:top_heroes][3][:hero] + ":" + string_padder(stats[:top_heroes][3][:hero], 12)} #{stats[:top_heroes][3][:games_played]} played, #{string_padder(stats[:top_heroes][3][:games_played].to_s, 10)}\t#{stats[:top_heroes][3][:playtime]} played,#{string_padder(stats[:top_heroes][3][:playtime].to_s, 9)}\t#{stats[:top_heroes][3][:winrate]} winrate
#{stats[:top_heroes][4][:hero] + ":" + string_padder(stats[:top_heroes][4][:hero], 12)} #{stats[:top_heroes][4][:games_played]} played, #{string_padder(stats[:top_heroes][4][:games_played].to_s, 10)}\t#{stats[:top_heroes][4][:playtime]} played,#{string_padder(stats[:top_heroes][4][:playtime].to_s, 9)}\t#{stats[:top_heroes][4][:winrate]} winrate```"
    end
  end
end
