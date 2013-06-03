class Cpanel::GroupsController < Cpanel::ApplicationController

	def index
		@groups = Group.all
	end

	
end
