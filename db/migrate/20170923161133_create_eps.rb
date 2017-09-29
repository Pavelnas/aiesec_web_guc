class CreateEps < ActiveRecord::Migration[5.0]
  def change
    create_table :eps do |t|
      t.string :name
      t.string :email
      t.integer :expa_id
      t.timestamps
    end
  end
end
