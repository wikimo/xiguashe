class Cpanel::TopicsController < Cpanel::ApplicationController


	def index
		@topics = Topic.all
	end


	def destroy
		
	end
end
