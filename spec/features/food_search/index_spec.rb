require 'rails_helper'

RSpec.describe 'Food Search Page' do
  it 'returns a list of foods based on search params' do
    stub_request(:get, food_search_path("Reese's Puffs")).
      to_return(:body => {
                          "data": [
                            {
                              "type": "food",
                              "attributes": {
                                "name": "Reese's Puffs",
                                "id": "rpuffs12",
                              }
                            },
                            {
                              "type": "food",
                              "attributes": {
                                "name": "Reese's Pieces",
                                "id": "rpieces13",
                              }
                            }
                            ]
                          })
    save_and_open_page
    expect(page).to have_content("Reese's Pieces") #
  end

  it 'will return an error message if food sear' do
    expect(page).to have_content("Invalid search. Please try again.")
  end

  xit 'displays a list of users favorite foods' do
  end
end
# Use Webmock instead of VCR because we do not have access to API yet
