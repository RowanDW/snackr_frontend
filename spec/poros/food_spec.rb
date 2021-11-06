require 'rails_helper'

RSpec.describe Food do
  before :each do
    attrs = {id: 1, name: 'avocado'}
    @food = Food.new(attrs)
  end

  it "exits and has attributes" do
    expect(@food).to be_a Food
    expect(@food.id).to eq(1)
    expect(@food.name).to eq('avocado')
  end
end
