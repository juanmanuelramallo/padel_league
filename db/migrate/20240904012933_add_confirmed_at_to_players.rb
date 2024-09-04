class AddConfirmedAtToPlayers < ActiveRecord::Migration[7.2]
  def change
    add_column :players, :confirmed_at, :timestamp, null: true
  end
end
