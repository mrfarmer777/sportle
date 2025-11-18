class Guess < ApplicationRecord
  belongs_to :game

  validates :first_name, :last_name, :game_id, presence: true
end
