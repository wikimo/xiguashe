class Cpanel::GroupsController < Cpanel::ApplicationController

	def index
		@groups = Group.all
	end


	def show
		@group = Group.find(params[:id])
	end

	def update
		
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to cpanel_groups_path
	end

	def change_status
		@group = Group.find(params[:id])

		if @group.state
			@group.update_attributes({ :state => false })
		else
			@group.update_attributes({ :state => true })
		end

		redirect_to cpanel_groups_path
	end
end
