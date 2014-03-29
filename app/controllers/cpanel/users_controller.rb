class Cpanel::UsersController < Cpanel::ApplicationController

  before_filter :require_admin
  before_filter :find_by_id, only: [:edit, :show, :update, :destroy]

	def index
		@users = User.search_in_cpanel(params[:search]).paginate(page: params[:page])
	end

  def edit
  end

	def show
	end

  def update
    if @user.update_attributes(params[:user])
      redirect_to cpanel_users_path, notice: t(:update_success)
    end
  end

	def destroy

		@user.destroy

		redirect_to cpanel_users_path
	end


  private 
    
    def find_by_id
      @user = User.find(params[:id])
    end

end
