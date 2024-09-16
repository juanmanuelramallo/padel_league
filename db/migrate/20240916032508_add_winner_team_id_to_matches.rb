class AddWinnerTeamIdToMatches < ActiveRecord::Migration[7.2]
  def change
    add_column :matches, :winner_team_id, :integer
  end
end
