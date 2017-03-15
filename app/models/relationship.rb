class Relationship < ApplicationRecord
	# belongs_to 关系的建立和之前一样。Rails会通过Symbol 获知外键的名字(例如, :follower对应的外键是follower_id,:followed对应的外键是followed_id),
	# 但Followed或Follower模型是不存在的，因此这里就要使用User这个类名。
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
	validates :follower_id, presence: true
	validates :followed_id, presence: true
end
