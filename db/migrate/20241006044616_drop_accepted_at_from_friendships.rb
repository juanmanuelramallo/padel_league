class DropAcceptedAtFromFriendships < ActiveRecord::Migration[7.2]
  def change
    remove_index :friendships, :accepted_at
    remove_column :friendships, :accepted_at, :datetime
  end
end
