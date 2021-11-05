class Meal

  attr_reader :id, :name, :rank, :foods
  def initialize(meal_attrs, foods_array = [])
    @id = meal_attrs[:id]
    @name = meal_attrs[:name]
    @rank = meal_attrs[:rank]
    @foods = create_foods(foods_array)
  end

  def create_foods(foods_array)
    foods_array.map do |food|
      food_attrs = {id: food[:id], name: food[:name]}
      Food.new(food_attrs)
    end
  end
end
