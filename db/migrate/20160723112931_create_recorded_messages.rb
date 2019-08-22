class CreateRecordedMessages < ActiveRecord::Migration[5.2]
  def up
    create_table :recorded_messages do |t|
      t.bigint :user_id, null: false, index: true
      t.string :message, null: false

      t.timestamps null: false
    end
  end

  def down
    drop_table recorded_messages
  end
end
