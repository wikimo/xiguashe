class Cpanel::ProductsController < Cpanel::ApplicationController

	def index
		@products = Product.search_in_cpanel(params[:search], params[:page])
	end


	def show
    @product = Product.find(params[:id])
	end

	def update
		
	end

	def destroy

	end

end
