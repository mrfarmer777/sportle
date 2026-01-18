# frozen_string_literal: true

class PlayerCardComponent < ViewComponent::Base
  attr_reader :player_target
  def initialize(player_target:)
    @player_target = player_target
  end
end
