ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.163.com",  
  :port                 => 25,  
  :domain               => "163.com",  
  :user_name            => "wikimo@163.com",  
  :password             => "iamwiki",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
} 