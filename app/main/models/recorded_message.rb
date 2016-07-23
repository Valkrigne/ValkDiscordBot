class RecordedMessage < ActiveRecord::Base
  has_one :author, class_name: 'User'

  validates_presence_of :user_id, :message
end
