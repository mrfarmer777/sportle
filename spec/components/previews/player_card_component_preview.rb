# frozen_string_literal: true

class PlayerCardComponentPreview < ViewComponent::Preview
  def default
    render(PlayerCardComponent.new(player_target: PlayerTarget.first))
  end
end
