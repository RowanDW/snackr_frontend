class FoodEntry
  attr_reader :id, :name, :average_rank
  def initialize(food_attrs)
    @id = food_attrs[:id]
    @name = food_attrs[:name]
    @average_rank = food_attrs[:average_rank]
  end
end
