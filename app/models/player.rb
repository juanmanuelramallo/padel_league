# == Schema Information
#
# Table name: players
#
#  id                 :bigint           not null, primary key
#  confirmation_token :string
#  confirmed_at       :datetime
#  email              :string
#  name               :string           not null
#  password_digest    :string
#  phone              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_players_on_confirmation_token  (confirmation_token) UNIQUE
#
class Player < ApplicationRecord
  has_secure_password :password, validations: false

  # Players that have been invited by this player
  has_many :invitees_invites, class_name: "Invite", foreign_key: :inviter_id, dependent: :destroy
  has_many :invitees, through: :invitees_invites, source: :invitee, class_name: "Player"

  # Players that this player has invited
  has_one :inviters_invite, class_name: "Invite", foreign_key: :invitee_id, dependent: :destroy
  has_one :inviter, through: :inviters_invite, source: :inviter, class_name: "Player"

  has_many :friendships, -> { where.not(accepted_at: nil) },
    foreign_key: :player_1_id,
    dependent: :destroy
  has_many :friends, through: :friendships, source: :player_2
  has_many :pending_friendships, -> { where(accepted_at: nil) },
    class_name: "Friendship",
    foreign_key: :player_1_id,
    dependent: :destroy
  has_many :pending_friends, through: :pending_friendships, source: :player_2

  accepts_nested_attributes_for :inviters_invite

  validates :name, presence: true
  validates :email,
    uniqueness: { allow_blank: true, case_sensitive: false },
    format: { allow_blank: true, with: URI::MailTo::EMAIL_REGEXP }
end
