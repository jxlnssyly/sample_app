class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 确保(follower_id,followed_id)组合是唯一的，这样用户就无法多次关注同一个用户了
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
