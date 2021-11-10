class BackendService
  def self.get_meals(user_id, date = DateTime.current.in_time_zone)
    response = conn.get("api/v1/users/#{user_id}/meals?date=#{date}")
    parse_json(response)
  end

  def self.new_meal(user_id, meal_hash)
    input = JSON.parse(meal_hash, symbolize_names: true)

    response = conn.post do |req|
      req.url "api/v1/users/#{user_id}/meals"
      req.params = input
    end

    parse_json(response)
  end

  def self.update_meal(user_id, meal_hash)
    response = conn.patch do |req|
      req.url "api/v1/users/#{user_id}/meals"
      req.params = meal_hash
    end
    parse_json(response)
  end

  def self.get_foods(user_id)
    response = conn.get("api/v1/users/#{user_id}/foods")
    parse_json(response)
  end

  def self.food_search(query)
    response = conn.get("api/v1/foods/search?query=#{query}")
    parse_json(response)
  end

  def self.login_user(email, name, token)
    response = conn.get('api/v1/users', { email: email, name: name, access_token: token })
    parse_json(response)
  end

  def self.get_graphs(user_id)
    response = conn.get("api/v1/users/#{user_id}/graphs")
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
