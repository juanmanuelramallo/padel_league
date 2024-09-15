require 'rails_helper'

RSpec.describe Player, type: :model do
  subject { create(:player) }

  describe 'associations' do
    it { is_expected.to have_many(:friendships).dependent(:destroy) }
    it { is_expected.to have_many(:friends).through(:friendships).source(:player_2) }
    it { is_expected.to have_many(:pending_friendships).dependent(:destroy).class_name('Friendship') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.allow_blank }
  end
end
