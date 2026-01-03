class PlayerTarget < ApplicationRecord
  has_many :games, dependent: :destroy

  validates :stats_api_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :batting_hand, presence: true
  validates :throwing_hand, presence: true
  validates :team_name, presence: true
  validates :league, presence: true
end
