class AddTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :stats_api_id, null: false
      t.timestamps
    end

  end
end
