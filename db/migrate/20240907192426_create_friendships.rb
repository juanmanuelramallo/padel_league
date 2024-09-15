class CreateFriendships < ActiveRecord::Migration[7.2]
  def change
    create_table :friendships do |t|
      t.references :player_1, null: false, foreign_key: { to_table: :players }
      t.references :player_2, null: false, foreign_key: { to_table: :players }
      t.datetime :accepted_at
      t.index %i[player_1_id player_2_id], unique: true
      t.index :accepted_at

      t.timestamps
    end
  end
end
