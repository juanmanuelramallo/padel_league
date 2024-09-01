class CreateScoreSets < ActiveRecord::Migration[7.2]
  def change
    create_table :score_sets do |t|
      t.references :match, null: false, foreign_key: true
      t.integer :score_1, null: false
      t.integer :score_2, null: false

      t.timestamps
    end
  end
end
