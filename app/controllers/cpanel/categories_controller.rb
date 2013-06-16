class Cpanel::CategoriesController < Cpanel::ApplicationController

  def index
  	
  	@categories = Category.all
  	@category = Category.new
  end


  def create
  	@category = Category.create(:name => params[:category][:name], :description => params[:category][:description])

  	if @category.save
  		redirect_to cpanel_categories_path,:notice  => 'create_group_success'
  	else

  	end
  end


  def update
  	
  end


  def show
  	
  end

  def destroy
  	
  end

end
