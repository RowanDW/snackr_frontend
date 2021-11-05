require 'rails_helper'

RSpec.describe Meal do
  before :each do
    attrs = {id: 1, name: 'breakfast', rank: 6}
    @meal = Meal.new(attrs)
  end

  it "exits and has attributes" do
    expect(@meal).to be_a Meal
    expect(@meal.id).to eq(1)
    expect(@meal.name).to eq('breakfast')
    expect(@meal.rank).to eq(6)
    expect(@meal.foods).to eq([])
  end

  it ".create_food_entries" do
    foods = [{"id": 1,
              "meal_id": 1,
              "food_id": 12345,
              "name": "bread"
            },
            {
              "id": 2,
              "meal_id": 1,
              "food_id": 68762,
              "name": "avocado"
            }]
    result = @meal.create_food_entries(foods)
    expect(result.size).to eq(2)
    expect(result.first).to be_a FoodEntry
    expect(result.first.name).to eq("bread")
  end
end
