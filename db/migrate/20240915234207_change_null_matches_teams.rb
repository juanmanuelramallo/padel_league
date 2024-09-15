class ChangeNullMatchesTeams < ActiveRecord::Migration[7.2]
  def change
    change_column_null :matches, :team_1_id, true
    change_column_null :matches, :team_2_id, true
  end
end
