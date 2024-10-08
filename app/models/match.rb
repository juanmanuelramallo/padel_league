# == Schema Information
#
# Table name: matches
#
#  id             :bigint           not null, primary key
#  draft          :boolean          default(FALSE)
#  played_at      :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  location_id    :bigint           not null
#  winner_team_id :integer
#
# Indexes
#
#  index_matches_on_location_id  (location_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class Match < ApplicationRecord
  belongs_to :location

  has_many :score_sets, dependent: :destroy
  has_many :score_sets_a, -> { where(team_id: "a") }, class_name: "ScoreSet"
  has_many :score_sets_b, -> { where(team_id: "b") }, class_name: "ScoreSet"
  has_many :match_players, dependent: :destroy
  has_many :match_players_a, -> { where(team_id: "a") }, class_name: "MatchPlayer"
  has_many :match_players_b, -> { where(team_id: "b") }, class_name: "MatchPlayer"
  has_many :players, through: :match_players
  has_many :confirmations, class_name: "MatchConfirmation"

  validates :played_at, presence: true

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :match_players_a, allow_destroy: true
  accepts_nested_attributes_for :match_players_b, allow_destroy: true
  accepts_nested_attributes_for :score_sets_a, allow_destroy: true
  accepts_nested_attributes_for :score_sets_b, allow_destroy: true

  enum :winner_team_id, MatchPlayer.team_ids, prefix: true

  def build_empty_match_players
    match_players_a_count = match_players_a.size
    match_players_b_count = match_players_b.size
    match_players_a.build([ {} ] * (2 - match_players_a_count).clamp(0, 2))
    match_players_b.build([ {} ] * (2 - match_players_b_count).clamp(0, 2))
  end

  def build_empty_score_sets
    score_sets_a.build([ {} ] * 5)
    score_sets_b.build([ {} ] * 5)
  end

  def score_sets_summary
    score_sets_by_position.map do |position, scores|
      "#{scores["a"].score}-#{scores["b"].score}"
    end.join(", ")
  end

  def score_sets_by_position
    score_sets.inject({}) do |hash, score_set|
      hash[score_set.position + 1] ||= {}
      hash[score_set.position + 1][score_set.team_id] = score_set

      hash
    end
  end

  def team_1_won?
    score_sets_a.map(&:score).sum > score_sets_b.map(&:score).sum
  end

  def team_2_won?
    score_sets_b.map(&:score).sum > score_sets_a.map(&:score).sum
  end
end
