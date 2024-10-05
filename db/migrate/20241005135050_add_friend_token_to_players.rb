class AddFriendTokenToPlayers < ActiveRecord::Migration[7.2]
  def change
    add_column :players, :friend_token, :string
    add_index :players, :friend_token, unique: true
  end
end
