class UserMailer < ApplicationMailer
  default from: 'noreply@westar.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to our app!')
  end
end