class SearchController < ApplicationController
  before_filter :form_action
  def index

  	render 'topics'
  end

  def topics

    @topics = Topic.search do
      keywords params[:query]
      paginate :page => params[:page] ? params[:page] : 1, :per_page => 10
    end.results

    @keyword = params[:query]
  end

  def users
  	@users = User.search do
      #with(:nickname, params[:query])
      keywords params[:query]
      paginate :page => params[:page] ? params[:page] : 1, :per_page => 10
  	end.results	

  	@keyword = params[:query]
  end

  def form_action
      if params[:action] == 'users'
        @form_action = search_users_path
      else
        @form_action = search_topics_path  
      end
  end


end
