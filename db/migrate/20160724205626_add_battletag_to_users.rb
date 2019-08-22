class AddBattletagToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :battletag, :string, null: true
  end
  def down
    drop_column :users, :battletag
  end
end
