require 'spec_helper'

describe DiscordBot do
  describe 'initialize' do
    let(:discord_bot) { build :discord_bot }

    it 'should have a token value' do
      expect(discord_bot.token).to_not be nil
    end

    it 'should have a app id' do
      expect(discord_bot.app_id).to_not be nil
    end
  end

  describe '#bot' do
    let(:discord_bot) { build :discord_bot }

    it 'should return a discord bot object' do
      expect(discord_bot.bot).to be_kind_of(Discordrb::Bot)
    end
  end
end
