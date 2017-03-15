class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end

    # 我们把user_id 和 created_at 放在一个数组中，告诉Rails我们要创建的是“多键索引”
    add_index :microposts, [:user_id, :created_at]
  end
end
