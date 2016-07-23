class User < ActiveRecord::Base
  has_many :recorded_messages

  validates_presence_of :discord_id, :name

  class << self
    def find_or_create(discord_id, display_name)
      discord_user = User.find_by(discord_id: discord_id)
      if discord_user.nil?
        discord_user = User.create! discord_id: discord_id, name: display_name
      end
      return discord_user
    end
  end
end
