class Cpanel::UsersController < Cpanel::ApplicationController


	def index

		
		@users = User.search_in_cpanel(params[:search], params[:page], User.per_page)
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
