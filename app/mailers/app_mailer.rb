class AppMailer < ActionMailer::Base
  helper :application
  
  default from: "joinus@bab.bo"

  def send_welcome_email(user)
    @user = user
    mail to: user.email, subject: "Welcome to 八寶!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: user.email, subject: "Please reset your password"
  end

end