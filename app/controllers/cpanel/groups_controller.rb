class Cpanel::GroupsController < Cpanel::ApplicationController

	def index
		@groups = Group.all
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
