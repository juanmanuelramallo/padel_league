require 'rails_helper'

RSpec.describe MatchPlayer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:match) }
    it { is_expected.to belong_to(:player) }
  end

  describe 'validations' do
    xit { is_expected.to validate_uniqueness_of(:player_id).scoped_to(:match_id) }
  end
end
