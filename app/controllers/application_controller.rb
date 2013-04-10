class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user,:current_logined?

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
      end 
    end

end
