class FoodSearchController < ApplicationController

  def index
    if params[:search].blank? || BackendFacade.food_search(params[:search]).empty?
      flash[:notice] = 'Invalid search. Please try again.'
      redirect_to food_search_path
    elsif params[:search]
      BackendFacade.food_search(params[:search])
    end
  end
end
