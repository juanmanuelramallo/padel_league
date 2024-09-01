class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
