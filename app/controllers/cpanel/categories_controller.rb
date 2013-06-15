class Cpanel::CategoriesController < Cpanel::ApplicationController

  def index
  	
  	@categories = Category.all

  end

end
