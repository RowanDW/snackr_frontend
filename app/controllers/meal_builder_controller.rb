class MealBuilderController < ApplicationController
  def index
    return if cookies[:meal].blank?

    meal   = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    @foods = meal[:attributes][:foods]
  end

  def create
    if cookies[:meal].present?
      meal_data = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
      meal = Meal.new(construct_meal_data(meal_data), meal_data[:attributes][:foods])
      reset_meal(meal)
      BackendService.new_meal(current_user_id, cookies[:meal])
      cookies[:meal].clear
      redirect_to dashboard_path
    else
      flash[:error] = 'Unable to create meal. Please add a food!'
      redirect_to meal_builder_path
    end
  end

  private

  def construct_meal_data(meal_data)
    meal_data[:attributes][:name]      = params[:meal_name]
    meal_data[:attributes][:meal_time] = params[:meal_time]
    {
      id: meal_data[:id],
      name: meal_data[:attributes][:name],
      meal_time: meal_data[:attributes][:meal_time]
    }
  end
end
