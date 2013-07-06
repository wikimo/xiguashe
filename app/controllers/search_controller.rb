class SearchController < ApplicationController

  def index

  	@topics = Topic.search do
		keywords params[:query]
	end.results

	@keyword = params[:query]
  end


end
