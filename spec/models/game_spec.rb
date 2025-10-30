require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'associations' do
    it { should belong_to(:player_target).required }
  end

  describe 'validations' do
    let(:subject) { build(:game) }

    it { should validate_presence_of(:status) }
  end
end
