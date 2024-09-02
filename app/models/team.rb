# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  player_1_id :bigint           not null
#  player_2_id :bigint           not null
#
# Indexes
#
#  index_teams_on_player_1_id  (player_1_id)
#  index_teams_on_player_2_id  (player_2_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_1_id => players.id)
#  fk_rails_...  (player_2_id => players.id)
#
class Team < ApplicationRecord
  belongs_to :player_1, class_name: "Player"
  belongs_to :player_2, class_name: "Player"
end
