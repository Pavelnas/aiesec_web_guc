class CreateExpas < ActiveRecord::Migration[5.0]
  def change
    create_table :expas do |t|

      t.timestamps
    end
  end
end
