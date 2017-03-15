class RelationshipsController < ApplicationController
	before_action :signed_in_user

	respond_to :html, :js

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_with @user
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		# 根据请求到的请求类型进行不同的操作
		respond_with @user
	end
end