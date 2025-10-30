require 'rails_helper'

RSpec.describe PlayerTarget, type: :model do

  describe 'associations' do
    it { should have_many(:games) }
  end

  describe 'validations' do
    let(:subject) { build(:player_target, stats_api_id: '123abcd') }

    it { should validate_presence_of(:stats_api_id) }
    it { should validate_uniqueness_of(:stats_api_id) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:batting_hand) }
    it { should validate_presence_of(:throwing_hand) }
    it { should validate_presence_of(:team_name) }
    it { should validate_presence_of(:league) }
  end
end
