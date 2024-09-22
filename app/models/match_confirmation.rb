# == Schema Information
#
# Table name: match_confirmations
#
#  id              :bigint           not null, primary key
#  confirmed_at    :datetime         not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  confirmed_by_id :bigint           not null
#  match_id        :bigint           not null
#
# Indexes
#
#  index_match_confirmations_on_confirmed_by_id  (confirmed_by_id)
#  index_match_confirmations_on_match_id         (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (confirmed_by_id => players.id)
#  fk_rails_...  (match_id => matches.id)
#
class MatchConfirmation < ApplicationRecord
  belongs_to :match
  belongs_to :confirmed_by, class_name: "Player"

  validates :confirmed_at, presence: true
  validate :confirmed_by_belongs_to_match

  private

  def confirmed_by_belongs_to_match
    return if match.match_players.any? { |match_player| match_player.player_id == confirmed_by_id }

    errors.add(:confirmed_by, "tiene que ser uno de los jugadores del partido")
  end
end
