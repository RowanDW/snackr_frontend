class FoodSearchController < ApplicationController
  def index
    @foods = BackendFacade.food_search(params[:search]) if params[:search]
  end
end
