# == Schema Information
#
# Table name: invites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invitee_id :bigint           not null
#  inviter_id :bigint           not null
#
# Indexes
#
#  index_invites_on_invitee_id  (invitee_id)
#  index_invites_on_inviter_id  (inviter_id)
#
# Foreign Keys
#
#  fk_rails_...  (invitee_id => players.id)
#  fk_rails_...  (inviter_id => players.id)
#
class Invite < ApplicationRecord
  belongs_to :invitee, class_name: "Player"
  belongs_to :inviter, class_name: "Player"
end
