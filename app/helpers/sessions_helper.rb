module SessionsHelper

	def sign_in(user)
		# 新建一个remember_token
		remember_token = User.new_remember_token
		# 把这个remember_token 放进cookies里面去
		cookies.permanent[:remember_token] = remember_token
		# 修改登录对象的remember_token，存入数据库的是加密后的token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		# 给sessionHelper对象一个成员变量，把这条记录赋值给他
		self.current_user = user
	end

	def current_user=(user)
	  @current_user = user
	end

	def current_user
	  remember_token = User.encrypt(cookies[:remember_token])
	  @current_user ||= User.find_by(remember_token: remember_token)
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url,notice: "请登录." 
      end
    end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end
end
