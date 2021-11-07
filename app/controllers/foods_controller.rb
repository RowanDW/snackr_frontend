class FoodsController < ApplicationController

  def create
    if cookies[:meal].nil?
      new_meal = Meal.new({}) # build a new meal
      require "pry"; binding.pry
    else
      # add food to an existing meal
    end
    redirect_to(meal_builder_path)
  end

  def destroy
    meal_data  = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    meal       = Meal.new(meal_data, meal_data[:attributes][:foods])

    meal.remove_food_by_food_id(params[:id].to_i)
    reset_meal(meal)
    redirect_to(meal_builder_path)
  end

  private

  def reset_meal(meal)
    cookies[:meal].clear
    cookies[:meal] = MealSerializer.new(meal).serializable_hash.to_json
  end
end
