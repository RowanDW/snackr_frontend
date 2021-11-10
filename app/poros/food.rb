class Food
  attr_reader :id, :name

  def initialize(food_attrs)
    @id = food_attrs[:id]
    @name = food_attrs[:name]
  end
end
