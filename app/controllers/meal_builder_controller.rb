class MealBuilderController < ApplicationController
  def index
    return if cookies[:meal].nil?

    meal   = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    @foods = meal[:attributes][:foods]
  end

  def create
    meal_data  = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    meal_data[:attributes][:name]      = params[:meal_name]
    meal_data[:attributes][:meal_time] = params[:meal_time]
    meal_hash = {
      id:        meal_data[:id],
      name:      meal_data[:attributes][:name],
      meal_time: meal_data[:attributes][:meal_time]
    }
    meal       = Meal.new(meal_hash, meal_data[:attributes][:foods])

    reset_meal(meal)

    # this response may not be necessary unless we want to use error message
    response = BackendService.new_meal(current_user_id, cookies[:meal])

    cookies[:meal].clear
    redirect_to dashboard_path
  end
end
