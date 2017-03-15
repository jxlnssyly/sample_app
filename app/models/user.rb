class User < ApplicationRecord
	#dependent: :destroy 设定程序在用户被删除的时候，其所属的微博也要被删除。
	has_many :microposts, dependent: :destroy
	# 默认情况下，Rails会寻找<class>_id形式的外键，其中<class>是模型类名的小写形式。现在，尽管我们处理的还是用户，但外键是
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	#默认情况下，在has_many through 关联中，Rails 会寻找关联名单数形式对应的外键，也就是说，下面的代码，会使用relationships表中的followed_id列生成一个数组
	# :source 参数，告知Rails followed_users 数组的来源是 followed 所代表的id集合。
	has_many :followed_users, through: :relationships, source: :followed

	#
	has_many :reverse_relationships, foreign_key: "followed_id",
									 class_name: "Relationship",
									 dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	# 存入数据库前把Email地址转换成全小写字母的形式，因为不是所有数据库适配器的索引都是区分大小写的。
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false} # case_sensitive 不区分大小写
	has_secure_password
	validates :password, length: { minimum: 6 }

	# Micropost.where("user_id = ?",id) 中的问号可以确保id的值在传入底层SQL查询语句之前做了适当的转义，避免"SQL注入"这种严重的安全隐患
	def feed
      Micropost.from_users_followed_by(self)
    end

    def following?(other_user)
    	relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
    	relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
    	relationships.find_by(followed_id: other_user.id).destroy
    end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end


end
