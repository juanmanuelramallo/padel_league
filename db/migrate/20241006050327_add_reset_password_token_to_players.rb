class AddResetPasswordTokenToPlayers < ActiveRecord::Migration[7.2]
  def change
    add_column :players, :reset_password_token, :string
  end
end
