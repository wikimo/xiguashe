class User < ActiveRecord::Base
	validates :password,:length  => {:minimum  => 6,:maximum  => 15},:if => :password_present?
	
	def password
	    @password
	  end

	def password=(pass)
		return unless pass
		@password =  pass
		generate_password pass
	end


	

	class << self
		def authenticate(username_or_email,password)
			user = User.find_by_username(username_or_email) || User.find_by_email(username_or_email)

			if user && user.hashed_password ==  Digest::SHA256.hexdigest(password + user.salt)
			  return user
			end

			false
		end

	end	

	private
	    def generate_password(pass)
	      salt = Array.new(10){rand(1024).to_s(36)}.join
	      self.salt, self.hashed_password = salt,Digest::SHA256.hexdigest(pass+salt)
	    end

	    def password_present?
	      !password.nil?
	    end
end
