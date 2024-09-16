# == Schema Information
#
# Table name: score_sets
#
#  id         :bigint           not null, primary key
#  position   :integer
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#  team_id    :integer
#
# Indexes
#
#  index_score_sets_on_match_id  (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#
class ScoreSet < ApplicationRecord
  belongs_to :match

  validates :score, presence: true

  default_scope { order(position: :asc) }

  enum :team_id, MatchPlayer.team_ids, prefix: true
end
