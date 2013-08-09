class CategoriesController < ApplicationController

  before_filter :logined?, :except => [:index]

  def index
  	
  end

end
