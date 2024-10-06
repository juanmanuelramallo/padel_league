# == Schema Information
#
# Table name: friendships
#
#  id          :bigint           not null, primary key
#  accepted_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  player_1_id :bigint           not null
#  player_2_id :bigint           not null
#
# Indexes
#
#  index_friendships_on_accepted_at                  (accepted_at)
#  index_friendships_on_player_1_id                  (player_1_id)
#  index_friendships_on_player_1_id_and_player_2_id  (player_1_id,player_2_id) UNIQUE
#  index_friendships_on_player_2_id                  (player_2_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_1_id => players.id)
#  fk_rails_...  (player_2_id => players.id)
#
class Friendship < ApplicationRecord
  self.ignored_columns = [ "accepted_at" ]

  belongs_to :player_1, class_name: "Player"
  belongs_to :player_2, class_name: "Player"

  validates :player_1_id, uniqueness: { scope: :player_2_id }
  validates :player_2_id, uniqueness: { scope: :player_1_id }
end
