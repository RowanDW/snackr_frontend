class Food

  attr_reader :food_id, :name, :brand
  def initialize(food_attrs)
    @food_id = food_attrs[:food_id]
    @name = food_attrs[:name]
    @brand = food_attrs[:brand]
  end
end
