class MealRatingController < ApplicationController
  def index
    @meals = BackendFacade.get_meals(current_user_id)
  end
end
