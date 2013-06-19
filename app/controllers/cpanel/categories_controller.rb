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

  def edit

    @category = Category.find(params[:id])
    
    render :json => @category
  end


  def update
    
  end


  def show
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    #will use ajax
    redirect_to cpanel_categories_path
  end


  def change_use
    @category = Category.find(params[:id])
    if @category.is_use
      @category.update_attributes({ :is_use => false })
    else
      @category.update_attributes({ :is_use => true })
    end
  end


end
