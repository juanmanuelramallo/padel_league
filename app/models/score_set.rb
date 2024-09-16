# == Schema Information
#
# Table name: score_sets
#
#  id         :bigint           not null, primary key
#  score      :integer
#  score_1    :integer
#  score_2    :integer
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
  attribute :rank, :integer
  belongs_to :match

  # validates :score, presence: true

  scope :with_rank, -> { select("rank() over (order by created_at) as rank, *").order(:created_at) }

  enum :team_id, MatchPlayer.team_ids, prefix: true
end
