require 'rails_helper'

RSpec.describe Meal do
  before :each do
    @attrs = {id: 1, name: 'breakfast', rank: 6, meal_time: "2012-03-05, 00:00:00"}
    @meal = Meal.new(@attrs)
    @food_attrs = [{"id": 1,
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
  end

  it "exits and has attributes" do
    expect(@meal).to be_a Meal
    expect(@meal.id).to eq(1)
    expect(@meal.name).to eq('breakfast')
    expect(@meal.rank).to eq(6)
    expect(@meal.meal_time).to eq("2012-03-05, 00:00:00")
    expect(@meal.foods).to eq([])
  end

  it "#create_food_entries" do
    result = @meal.create_food_entries(@food_attrs)
    expect(result.size).to eq(2)
    expect(result.first).to be_a FoodEntry
    expect(result.first.name).to eq("bread")
  end

  it "#food_names" do
    meal2 = Meal.new(@attrs, @food_attrs)

    expect(meal2.food_names).to eq(["bread", "avocado"])
  end

  it '#food_entry_by_food_id' do
    meal2 = Meal.new(@attrs, @food_attrs)

    expect(meal2.food_entry_by_food_id(12345)).to be_a(FoodEntry)
    expect(meal2.food_entry_by_food_id(12345).name).to eq('bread')
  end

  it '#remove_food_by_food_id' do
    meal2 = Meal.new(@attrs, @food_attrs)

    expect(meal2.foods.count).to be(2)
    expect(meal2.food_entry_by_food_id(12345)).to_not be_nil

    meal2.remove_food_by_food_id(12345)
    expect(meal2.foods.count).to be(1)
    expect(meal2.food_entry_by_food_id(12345)).to be_nil
  end
end
