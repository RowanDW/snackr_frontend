class BackendService

  def self.get_meals(date = DateTime.current.beginning_of_day)
    response = conn.get("api/v1/users/#{session[:user_id]}/meals?date=#{query}")
    parse_json(response)
  end

  def self.new_meal(meal_hash)
    response = conn.post("api/v1/users/#{session[:user_id]}/meals", meal_hash)
    parse_json(response)
  end

  def self.update_meal(meal_hash)
    response = conn.patch("api/v1/users/#{session[:user_id]}/meals", meal_hash)
    parse_json(response)
  end

  def self.get_foods()# PARAMS NEED TO BE FIGURED OUT
    response = conn.get("api/v1/users/#{session[:user_id]}/foods")
    parse_json(response)
  end

  def self.food_search(query)
    response = conn.get("api/v1/foods/search?query=#{query}")
    parse_json(response)
  end

  def self.login_user(email, name, token)
    response = conn.get("api/v1/users?email=#{user_info}&name=#{name}&access_token=#{token}")
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: 'https://snackr-backend.herokuapp.com/') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
