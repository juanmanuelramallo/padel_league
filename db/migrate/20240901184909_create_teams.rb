class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.references :player_1,
        null: false,
        foreign_key: { to_table: :players }
      t.references :player_2,
        null: false,
        foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
