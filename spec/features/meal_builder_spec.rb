require 'rails_helper'

RSpec.describe 'visiting the meal builder' do
  before(:each) do
    visit meal_builder_path
  end

  it 'has a button to add foods to the meal' do
    expect(page).to have_button('Add food')
  end
end
