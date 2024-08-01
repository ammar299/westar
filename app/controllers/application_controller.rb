class ApplicationController < ActionController::Base
  def home
    @message = "Welcome to my Rails application!"
  end
end
