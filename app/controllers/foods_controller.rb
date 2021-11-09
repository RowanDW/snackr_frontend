class FoodsController < ApplicationController

  def create
    food_params = {food_id: params[:food_id], food_name: params[:food_name]}
    if cookies[:meal].nil? || cookies[:meal].empty?
      meal = Meal.new({})
    else
      meal_data  = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
      meal       = Meal.new(meal_data, meal_data[:attributes][:foods])
    end
    meal.add_food_entry(food_params)
    reset_meal(meal)
    redirect_to(meal_builder_path)
  end

  def destroy
    meal_data  = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    meal       = Meal.new(meal_data, meal_data[:attributes][:foods])

    meal.remove_food_by_food_id(params[:id].to_i)
    reset_meal(meal)
    redirect_to(meal_builder_path)
  end
end
