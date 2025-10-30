class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.references :player_target, foreign_key: { to_table: :player_targets }
      t.string :total_guesses, default: 0
      t.string :status, default: 'started'
      t.boolean :found_player, default: false
      t.boolean :found_team, default: false
      t.boolean :found_position, default: false
      t.boolean :found_jersey_number, default: false
      t.boolean :found_throwing_hand, default: false
      t.boolean :found_batting_hand, default: false
      t.boolean :found_league, default: false

      t.timestamps
    end
  end
end
