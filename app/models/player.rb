# == Schema Information
#
# Table name: players
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string           not null
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Player < ApplicationRecord
  has_secure_password :password, validations: false
end
