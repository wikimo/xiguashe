class HomeController < ApplicationController
	before_filter :login_redirect, :except => [:about,:contact,:links]

	def about
		
	end

	def contact
		
	end

	def links
		
	end
end
