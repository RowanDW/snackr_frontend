class FoodsController < ApplicationController
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
