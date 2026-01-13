# frozen_string_literal: true

class PlayerCardComponent < ViewComponent::Base
  def initialize(player_target:)
    @player_target = player_target
  end
end
