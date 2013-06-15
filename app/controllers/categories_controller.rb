class CategoriesController < ApplicationController

  before_filter :logined?, :except => [:index]

  def index
  	
  	@categories = Category.all

  end

end
