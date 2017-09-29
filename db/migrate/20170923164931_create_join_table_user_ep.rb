class CreateJoinTableUserEp < ActiveRecord::Migration[5.0]
  def change
    create_join_table :Users, :Eps do |t|
       t.index [:user_id, :ep_id]
       t.index [:ep_id, :user_id]
    end
  end
end
