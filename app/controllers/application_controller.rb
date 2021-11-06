class ApplicationController < ActionController::Base
  helper_method :current_user_id, :current_user_name

  def current_user_id
    session[:user_id]
  end

  def current_user_name
    session[:name]
  end
end
