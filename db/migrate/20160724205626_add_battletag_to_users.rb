class AddBattletagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :battletag, :string, null: true
  end
  def self.down
    drop_column :users, :battletag
  end
end
