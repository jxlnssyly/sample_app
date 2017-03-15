class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
  	add_index :users, :email,unique: true # 索引本身不能保证唯一性，所以还要指定unique:true
  end
end
