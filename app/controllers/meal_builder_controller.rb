class MealBuilderController < ApplicationController
  def index
    return if cookies[:meal].nil?

    meal   = JSON.parse(cookies[:meal], symbolize_names: true)[:data]
    @foods = meal[:attributes][:foods]
  end
end
