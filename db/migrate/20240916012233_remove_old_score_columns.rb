class RemoveOldScoreColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :score_sets, :score_1
    remove_column :score_sets, :score_2
  end
end
