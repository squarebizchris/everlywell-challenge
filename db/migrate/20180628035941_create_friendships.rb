class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :member_id, null: false
      t.integer :friend_id, null: false

      t.timestamps
    end
  end
end
