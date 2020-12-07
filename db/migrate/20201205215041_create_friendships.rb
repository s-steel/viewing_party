class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.bigint :follower_id
      t.bigint :followed_id
    end
    add_foreign_key :friendships, :users, column: :follower_id
    add_foreign_key :friendships, :users, column: :followed_id
  end
end
