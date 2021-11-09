class DashboardController < ApplicationController

  def index
    @today = DateTime.current
    @meals = BackendFacade.get_meals(current_user_id)
    @graphs = BackendFacade.get_graphs(current_user_id)
  end
end
