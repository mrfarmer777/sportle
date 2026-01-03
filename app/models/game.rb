class Game < ApplicationRecord
  belongs_to :player_target, required: true
  has_many :guesses, dependent: :destroy

  validates :status, presence: true
end
