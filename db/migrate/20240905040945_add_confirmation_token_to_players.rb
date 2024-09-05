class AddConfirmationTokenToPlayers < ActiveRecord::Migration[7.2]
  def change
    add_column :players, :confirmation_token, :string
    add_index :players, :confirmation_token, unique: true
  end
end
