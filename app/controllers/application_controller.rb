class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user,:current_logined?

  def render_404
    render_optional_error_file(404)
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    if ["404","403", "422", "500"].include?(status)
      render :template => "/errors/#{status}", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    else
      render :template => "/errors/unknown", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    end
  end
  
  protected
    def current_user
	    #@current_user ||= User.find(session[:uid]) if  session[:uid]
      #p "cookie #{cookies[:auth_token]  }"
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]  
	  end

    def current_logined?
	    !!current_user
	  end

    def logined?
      if !current_logined?
        redirect_to login_path,:notice  =>  t(:user_not_login)
      end 
    end

    def login_redirect
      redirect_to recommend_topic_path if current_logined?
    end

end
