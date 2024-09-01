class CreateMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :matches do |t|
      t.references :location, null: false, foreign_key: true
      t.datetime :played_at, null: false
      t.references :team_1,
        null: false,
        foreign_key: { to_table: :teams }
      t.references :team_2,
        null: false,
        foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
