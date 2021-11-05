require 'rails_helper'

RSpec.describe Food do
  before :each do
    attrs = {food_id: 1, name: 'avocado', brand: 'whole foods'}
    @food = Food.new(attrs)
  end

  it "exits and has attributes" do
    expect(@food).to be_a Food
    expect(@food.food_id).to eq(1)
    expect(@food.name).to eq('avocado')
    expect(@food.brand).to eq('whole foods')
  end
end
