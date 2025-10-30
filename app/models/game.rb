class Game < ApplicationRecord
  belongs_to :player_target, required: true

  validates :status, presence: true
end
