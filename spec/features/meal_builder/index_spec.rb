require 'rails_helper'

RSpec.describe 'visiting the meal builder' do
  before(:each) do
    
  end

  it 'has a button to add foods to the meal' do
    expect(page).to have_button('Add food')
  end

  it 'has a form to add the meal time' do
    expect(page).to have_field(:meal_time)
    expect(page).to have_button('Save meal')
  end

  it 'has a delete button next to each food' do
    within '#food-123' do
      expect(page).to have_content('Meatballs')
      expect(page).to have_button('Delete')
    end

    within '#food-456' do
      expect(page).to have_content('Spaghetti')
      expect(page).to have_button('Delete')
    end

    within '#food-123' do
      click_button('Delete')
    end

    expect(current_path).to eq(meal_builder_path)
  end
end
