class ApplicationController < ActionController::Base
  helper_method :current_user_id, :current_user_name

  def current_user_id
    session[:user_id]
  end

  def current_user_name
    session[:name]
  end

  private

  def reset_meal(meal)
    cookies[:meal]&.clear
    cookies[:meal] = MealSerializer.new(meal).serializable_hash.to_json
  end
end
