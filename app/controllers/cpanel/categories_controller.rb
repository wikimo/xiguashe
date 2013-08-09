class Cpanel::CategoriesController < Cpanel::ApplicationController

  def index
  	
  	@categories = Category.order_desc_by_created_at(params[:page], Category.per_page)
  	
  end


  def new
    @category = Category.new
  end

  def create
  	@category = Category.create(:name => params[:category][:name], :description => params[:category][:description])

  	if @category.save
  		redirect_to cpanel_categories_path,:notice  => t(:create_success)
  	else

  	end
  end

  def edit

    @category = Category.find(params[:id])
    
  end


  def update
    @category = Category.find(params[:category][:id])

    if @category.update_attributes(params[:category])
      redirect_to cpanel_categories_path, :notice => t(:update_success)
    else
      render 'edit'  #error
    end
  end


  def show
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    #will use ajax
    redirect_to cpanel_categories_path, :notice => t(:delete_success)
  end


  def change_use
    @category = Category.find(params[:id])
    if @category.is_use
      @category.update_attributes({ :is_use => false })
    else
      @category.update_attributes({ :is_use => true })
    end

    redirect_to cpanel_categories_path
  end


end
