require 'rails_helper'

RSpec.describe Guess, type: :model do
  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:game_id) }
  end

  context 'associations' do
    it { should belong_to(:game) }
  end
end
