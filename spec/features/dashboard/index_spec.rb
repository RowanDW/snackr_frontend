require 'rails_helper'

RSpec.describe 'The dashboard' do
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return(1)
    allow_any_instance_of(ApplicationController).to receive(:current_user_name).and_return("Rowan")
    allow(DateTime).to receive(:current).and_return('2021-11-06T00:14:46+00:00'.to_date)
  end

  it "shows a list of todays meals" do
    mock_response = File.read('spec/fixtures/responses/meals.json')
    allow(BackendService).to receive(:get_meals).and_return(JSON.parse(mock_response, symbolize_names: true))

    visit dashboard_path
    within('#todays-meals') do
      expect(page).to have_content("Today's Meals")
      expect(page).to have_content("November 06, 2021")

      within('#meal-1') do
        expect(page).to have_content("Breakfast")
        expect(page).to have_content("6:30 am")
        expect(page).to have_content("Foods:")
        expect(page).to have_content("bread")
        expect(page).to have_content("avocado")
      end

      within('#meal-2') do
        expect(page).to have_content("Lunch")
        expect(page).to have_content("12:00 pm")
        expect(page).to have_content("Foods:")
        expect(page).to have_content("bread")
        expect(page).to have_content("avocado")
      end
    end
  end

  xit "shows meal rating if present" do
    mock_response = File.read('spec/fixtures/responses/meals.json')
    allow(BackendService).to receive(:get_meals).and_return(JSON.parse(mock_response, symbolize_names: true))

    visit dashboard_path

    within('#meal-1') do
      expect(page).to have_content("Breakfast - 8/10")
    end

    within('#meal-2') do
      expect(page).to have_content("Lunch")
      expect(page).to_not have_content("/10")
    end
  end

  it "shows a message if no meals have been logged", :vcr do
    allow(BackendService).to receive(:get_meals).and_return({"data": []})

    visit dashboard_path
    save_and_open_page
    within('#todays-meals') do
      expect(page).to have_content("Today's Meals")
      expect(page).to have_content("November 06, 2021")
      expect(page).to have_content("You haven't logged any meals yet today")
    end
  end

  it 'has a button that takes user to the meal builder', :vcr do
    visit dashboard_path

    click_button('Add a meal')
    expect(current_path).to eq(meal_builder_path)
  end

  xit 'has a button that takes user to the meal rating page' do
    visit dashboard_path

    click_button('Rate meals')
    expect(current_path).to eq(meal_rating_path)
  end
end
