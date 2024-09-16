class ChangeScoreSets < ActiveRecord::Migration[7.2]
  def change
    add_column :score_sets, :score, :integer
    add_column :score_sets, :team_id, :integer
  end
end
