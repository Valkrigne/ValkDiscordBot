class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.bigint :discord_id, null: false, index: true, unique: true
      t.string :name, null: false

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
