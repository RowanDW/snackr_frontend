class MealBuilderController < ApplicationController
  def index
    meal   = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    @foods = meal[:attributes][:foods]
  end
end
