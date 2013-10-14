class SearchController < ApplicationController

  def index

  	@topics = Topic.search do
		  keywords params[:query]
      paginate :page => params[:page] ? params[:page] : 1
	  end.results

	  @keyword = params[:query]
  end

  def users
  	@users = User.search do
      #with(:nickname, params[:query])
      keywords params[:query]
      paginate :page => params[:page] ? params[:page] : 1
  	end.results	

  	@keyword = params[:query]
  end


end
