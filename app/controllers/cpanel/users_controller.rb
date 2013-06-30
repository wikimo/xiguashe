class Cpanel::UsersController < Cpanel::ApplicationController


	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to cpanel_users_path
	end

	def change_password
		
	end

	#目前没有状态字段
	def change_status
		
	end
end
