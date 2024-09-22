class CreateMatchConfirmations < ActiveRecord::Migration[7.2]
  def change
    create_table :match_confirmations do |t|
      t.references :match, null: false, foreign_key: true
      t.references :confirmed_by, null: false, foreign_key: { to_table: :players }
      t.timestamp :confirmed_at, null: false

      t.timestamps
    end
  end
end
