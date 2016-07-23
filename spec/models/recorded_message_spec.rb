require 'spec_helper'

describe RecordedMessage, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :message }
    end
  end

  describe 'db columns' do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:message).of_type(:string) }
  end
end
