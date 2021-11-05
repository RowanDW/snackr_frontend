class BackendFacade
  def self.get_meals(date = DateTime.current.beginning_of_day)
    meals = BackendService.get_meals(date)
    meals[:data].map do |meal|
      meal_hash = {id: meal[:id], name: meal[:attributes][:name], rank: meal[:attributes][:rank]}
      food_entries = meal[:relationships][:food_entries][:data]
      Meal.new(meal_hash, food_entries)
    end
  end

  def self.get_foods()
    foods = BackendService.get_foods
    foods[:data].map do |food|
      food_attrs = {id: food[:id], name: food[:attributes][:name], average_rank: food[:attributes][:average_rank]}
      FoodEntry.new(food_attrs)
    end
  end

  def self.food_search(query)
    query.gsub!(' ', '+')
    foods = BackendService.food_search(query)
    foods[:data].map do |food|
      food_attrs = {food_id: food[:attributes][:food_id], name: food[:attributes][:name], brand: food[:attributes][:brand]}
      Food.new(food_attrs)
    end
  end

  def self.login_user(email, name, token)
    user = BackendService.login_user(email, name, token)
    user[:data][:id]
  end
end
