class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.references :player_target, foreign_key: { to_table: :player_targets}
      t.string :result
      t.string :total_guesses, default: 0
      t.string :status, default: 'started'
      t.timestamps
    end
  end
end
