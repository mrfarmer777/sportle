# frozen_string_literal: true

class PlayerCardComponentPreview < ViewComponent::Preview
  def default
    render(PlayerCardComponent.new(player_target: "player_target"))
  end
end
