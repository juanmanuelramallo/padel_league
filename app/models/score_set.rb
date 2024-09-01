# == Schema Information
#
# Table name: score_sets
#
#  id         :bigint           not null, primary key
#  score_1    :integer          not null
#  score_2    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
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

  validates :score_1, :score_2, presence: true
end
