require 'rails_helper'

RSpec.describe 'Food Search Page' do
  before :each do
    visit food_search_path

    fill_in :food_search, with: "Reese's Puffs"

    click_on 'Search'
  end
  it 'returns a list of foods based on search params', :vcr do
    expect(page).to have_content('Results') #
  end

  it 'displays a list of users favorite foods' do
  end
end
# Use Webmock instead of VCR because we do not have access to API yet
