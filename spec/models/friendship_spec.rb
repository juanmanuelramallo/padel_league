require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:player_1).class_name('Player') }
    it { is_expected.to belong_to(:player_2).class_name('Player') }
  end

  describe 'validations' do
    subject do
      create(
        :friendship,
        player_1: create(:player, name: "Paquito"),
        player_2: create(:player, name: "Chingo")
      )
    end

    it { is_expected.to validate_uniqueness_of(:player_1_id).scoped_to(:player_2_id) }
    it { is_expected.to validate_uniqueness_of(:player_2_id).scoped_to(:player_1_id) }
  end
end
