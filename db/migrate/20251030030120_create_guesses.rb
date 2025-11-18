class CreateGuesses < ActiveRecord::Migration[8.1]
  def change
    create_table :guesses do |t|
      t.references :game, foreign_key: { to_table: :games }
      t.string :first_name
      t.string :last_name
      t.references :target, foreign_key: { to_table: :player_targets }, null: true
      t.timestamps
    end
  end
end
