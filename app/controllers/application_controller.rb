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
	    @current_user ||= User.find(session[:uid]) if  session[:uid]  
	  end

    def current_logined?
	    !!current_user
	  end

    def logined?
      if !current_logined?
        redirect_to login_path,:notice  =>  t(:user_not_login)
      else
        redirect_to user_path(current_user)
      end 
    end

end
