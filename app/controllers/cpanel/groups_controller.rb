class Cpanel::GroupsController < Cpanel::ApplicationController

	def index
		@groups = Group.all
	end

	def change_status
		@group = Group.find(param[:id])

		if @group.status 
			@group.update_attributes({ :status => false })
		else
			@group.update_attributes({ :status => true })
		end

		redirect_to cpanel_groups_path
	end
end
