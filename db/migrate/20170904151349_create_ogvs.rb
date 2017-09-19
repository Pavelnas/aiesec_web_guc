class CreateOgvs < ActiveRecord::Migration[5.0]
  def change
    create_table :ogvs do |t|
      t.integer :project_id
      t.references :faction, foreign_key: true

      t.timestamps
    end
  end
end
