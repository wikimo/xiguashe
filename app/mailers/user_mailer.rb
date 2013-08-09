# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "wikimo@163.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "登录密码重置，来自西瓜社"
  end
end
