class Cpanel::ProductsController < Cpanel::ApplicationController

	def index
		@products = Product.search_in_cpanel(params[:search], params[:page])
	end


	def show
	end

	def update
		
	end

	def destroy
	end

end
