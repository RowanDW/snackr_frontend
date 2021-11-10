class MealRatingController < ApplicationController
  def index
    @meals = BackendFacade.get_meals(current_user_id)
  end

  def update
    meals = params[:meal]
    rank = params[:rating].to_i
    if meals
      meals.each do |meal|
        meals_hash = { "rank": rank, "meal_id": meal.to_i }
        BackendService.update_meal(current_user_id, meals_hash)
      end
      redirect_to dashboard_path
    else
      flash[:error] = 'Unable to add ranking. Please select meals!'
      redirect_to meal_rating_path
    end
  end
end
