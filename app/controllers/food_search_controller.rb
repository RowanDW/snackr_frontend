class FoodSearchController < ApplicationController

  def index
    if params[:search]
      @foods = BackendFacade.food_search(params[:search])
    end
  end
end
