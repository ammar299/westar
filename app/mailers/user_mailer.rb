class UserMailer < ApplicationMailer
  default from: 'noreply@westar.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to our app!')
  end

  def order_confirmation(email, order)
    @email = email
    @order = order
    mail(to: @email, subject: 'Order Confirmation')
  end
end