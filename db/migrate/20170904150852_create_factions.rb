class CreateFactions < ActiveRecord::Migration[5.0]
  def change
    create_table :factions do |t|
      t.string :faction_name
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
