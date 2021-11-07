require 'rails_helper'

RSpec.describe 'Food Search Page' do
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return(1)
    allow_any_instance_of(ApplicationController).to receive(:current_user_name).and_return("Duke")
    allow(DateTime).to receive(:current).and_return('2021-11-06T00:14:46:00:00'.to_date)
  end

  it 'has search bar to search food by name' do
    visit food_search_path

    expect(page).to have_field(:search)
  end

  it 'returns a list of foods based on search params' do
    mock_response = File.read('spec/fixtures/responses/food_search.json')
    allow(BackendService).to receive(:food_search).and_return(JSON.parse(mock_response, symbolize_names: true))

    visit food_search_path

    fill_in :search, with: "Blueberries"
    click_on "Search"

    expect(page).to have_content("Blueberries")
    expect(current_path).to eq(food_search_path)
  end

  it 'can add a food to a meal' do
    mock_response = File.read('spec/fixtures/responses/food_search.json')
    allow(BackendService).to receive(:food_search).and_return(JSON.parse(mock_response, symbolize_names: true))

    visit food_search_path

    fill_in :search, with: "Blueberries"
    click_on "Search"

    within '#food-1' do
      click_button('Add to Meal')
    end

    expect(current_path).to eq(meal_builder_path)
  end

  xit 'will return an error message if search params are empty' do
    visit food_search_path

    click_on "Search"

    expect(current_path).to eq(food_search_path)
    expect(page).to have_content("Invalid search. Please try again.")
  end
end
