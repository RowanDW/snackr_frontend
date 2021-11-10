class DashboardController < ApplicationController
  def index
    @today = DateTime.current.in_time_zone.to_datetime
    @meals = BackendFacade.get_meals(current_user_id)
    @graphs = BackendFacade.get_graphs(current_user_id)
  end
end
