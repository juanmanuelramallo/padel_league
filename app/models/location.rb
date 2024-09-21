# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string           default(""), not null
#  latitude   :string           default(""), not null
#  longitude  :string           default(""), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  validates :name, presence: true

  has_one_attached :image
end
