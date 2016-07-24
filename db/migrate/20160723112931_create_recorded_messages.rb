class CreateRecordedMessages < ActiveRecord::Migration
  def self.up
    create_table :recorded_messages do |t|
      t.bigint :user_id, null: false, index: true
      t.string :message, null: false

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :recorded_messages
  end
end
