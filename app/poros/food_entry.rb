class FoodEntry
  attr_reader :id, :name, :food_id, :average_rank
  
  def initialize(food_attrs)
    @id           = food_attrs[:id]
    @name         = food_attrs[:name]
    @food_id      = food_attrs[:food_id] #edamam
    @average_rank = food_attrs[:average_rank]
  end
end
