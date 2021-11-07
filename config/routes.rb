Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get  "/auth/:provider/callback", to: 'sessions#omniauth'
  get '/dashboard', to: 'dashboard#index'

  get '/meal_builder', to: 'meal_builder#index'
  get '/food_search', to: 'food_search#index'
end
