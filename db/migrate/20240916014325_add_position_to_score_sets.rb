class AddPositionToScoreSets < ActiveRecord::Migration[7.2]
  def change
    add_column :score_sets, :position, :integer
  end
end
