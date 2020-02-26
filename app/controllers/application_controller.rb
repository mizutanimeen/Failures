class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def user_unlogged_in
    if logged_in?
      redirect_to root_path
    end
  end
end
