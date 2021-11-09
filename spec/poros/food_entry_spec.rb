require 'rails_helper'

RSpec.describe FoodEntry do
  before :each do
    attrs = {id: 1, food_name: 'avocado'}
    @food = FoodEntry.new(attrs)
  end

  it "exits and has attributes" do
    expect(@food).to be_a FoodEntry
    expect(@food.id).to eq(1)
    expect(@food.food_name).to eq('avocado')
    expect(@food.average_rank).to eq(nil)
  end
end
