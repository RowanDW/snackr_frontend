require 'rails_helper'

RSpec.describe 'visiting the meal builder' do
  before(:each) do
    spaghetti_data = File.read('spec/fixtures/responses/spaghetti.json')

    allow_any_instance_of(ApplicationController).to receive(:cookies).and_return({ meal: spaghetti_data })

    visit meal_builder_path
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

  it 'can save the meal', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return(1)
    allow(DateTime).to receive(:current).and_return('2021-11-09T00:14:46:00:00'.to_date)

    fill_in(:meal_name, with: 'Spaghetti & Meatballs')
    fill_in(:meal_time, with: '2021-11-09T18:32' )
    click_button('Save meal')

    expect(current_path).to eq(dashboard_path)
    within('#todays-meals') do
      expect(page).to have_content('Spaghetti & Meatballs')
    end
  end
end
