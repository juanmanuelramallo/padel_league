# == Schema Information
#
# Table name: match_players
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#  player_id  :bigint           not null
#  team_id    :integer
#
# Indexes
#
#  index_match_players_on_match_id   (match_id)
#  index_match_players_on_player_id  (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (player_id => players.id)
#
class MatchPlayer < ApplicationRecord
  belongs_to :match
  belongs_to :player

  enum team_id: {
    a: 0,
    b: 10
  }, _prefix: true

  validates :player_id, uniqueness: { scope: :match_id }
end
