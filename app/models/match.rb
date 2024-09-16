# == Schema Information
#
# Table name: matches
#
#  id          :bigint           not null, primary key
#  played_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :bigint           not null
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
  has_many :match_players, dependent: :destroy
  has_many :match_players_a, -> { where(team_id: "a") }, class_name: "MatchPlayer"
  has_many :match_players_b, -> { where(team_id: "b") }, class_name: "MatchPlayer"
  has_many :players, through: :match_players

  validates :played_at, presence: true

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :match_players_a, allow_destroy: true
  accepts_nested_attributes_for :match_players_b, allow_destroy: true
  accepts_nested_attributes_for :score_sets, allow_destroy: true

  def build_empty_match_players
    match_players_a_count = match_players_a.size
    match_players_b_count = match_players_b.size
    match_players_a.build([ {} ] * (2 - match_players_a_count).clamp(0, 2))
    match_players_b.build([ {} ] * (2 - match_players_b_count).clamp(0, 2))
  end

  def team_1_won?
    score_sets.count { |score_set| score_set.score_1 > score_set.score_2 } > score_sets.size / 2
  end

  def team_2_won?
    score_sets.count { |score_set| score_set.score_1 < score_set.score_2 } > score_sets.size / 2
  end
end
