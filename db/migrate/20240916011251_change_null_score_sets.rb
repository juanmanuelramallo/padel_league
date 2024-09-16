class ChangeNullScoreSets < ActiveRecord::Migration[7.2]
  def change
    change_column_null :score_sets, :score_1, true
    change_column_null :score_sets, :score_2, true
  end
end
