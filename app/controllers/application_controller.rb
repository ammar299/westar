class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  def home
    @message = "Welcome to my Rails application!"
  end
end
