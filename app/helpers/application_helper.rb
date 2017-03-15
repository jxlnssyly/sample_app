module ApplicationHelper

	def full_title(page_title)
		base_title = "Ruby on Rails Tutorial Sample App"
		# if page_title.empty?
		# 	base_title
		# else
		# 	"#{base_title} | #{page_title}" 
		# end

		# 与上面的代码相等
		page_title.empty? ? base_title : "#{base_title} | #{page_title}" 
	end

end
