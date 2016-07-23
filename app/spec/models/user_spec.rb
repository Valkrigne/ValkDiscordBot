require 'spec_helper'

describe User, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of :discord_id }
      it { should validate_presence_of :name }
    end
  end

  describe 'db columns' do
    it { should have_db_column(:discord_id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
  end
end
