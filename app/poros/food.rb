class Food

  attr_reader :id, :name, :brand
  def initialize(food_attrs)
    @id = food_attrs[:id]
    @name = food_attrs[:name]
    @brand = food_attrs[:brand]
  end
end
