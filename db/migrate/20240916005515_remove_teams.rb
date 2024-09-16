class RemoveTeams < ActiveRecord::Migration[7.2]
  def change
    remove_column :matches, :team_1_id
    remove_column :matches, :team_2_id
    drop_table :teams
  end
end
