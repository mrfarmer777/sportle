class CreatePlayerTargets < ActiveRecord::Migration[8.1]
  def change
    create_table :player_targets do |t|
      t.timestamps
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :position, null: false
      t.string :team_name, null: false
      t.string :jersey_number, null: false
      t.string :throwing_hand, null: false
      t.string :batting_hand, null: false
      t.string :league, null: false
      t.string :stats_api_id, null: false
    end
  end
end
