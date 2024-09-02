# == Schema Information
#
# Table name: matches
#
#  id          :bigint           not null, primary key
#  played_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :bigint           not null
#  team_1_id   :bigint           not null
#  team_2_id   :bigint           not null
#
# Indexes
#
#  index_matches_on_location_id  (location_id)
#  index_matches_on_team_1_id    (team_1_id)
#  index_matches_on_team_2_id    (team_2_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (team_1_id => teams.id)
#  fk_rails_...  (team_2_id => teams.id)
#
class Match < ApplicationRecord
  belongs_to :location
  belongs_to :team_1, class_name: "Team"
  belongs_to :team_2, class_name: "Team"

  has_many :score_sets

  validates :played_at, presence: true

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :team_1
  accepts_nested_attributes_for :team_2
  accepts_nested_attributes_for :score_sets, allow_destroy: true

  def team_1_won?
    score_sets.count { |score_set| score_set.score_1 > score_set.score_2 } > score_sets.size / 2
  end

  def team_2_won?
    score_sets.count { |score_set| score_set.score_1 < score_set.score_2 } > score_sets.size / 2
  end
end
