require 'rails_helper'

RSpec.describe 'visiting the meal rating page', :vcr do
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return(1)
    allow_any_instance_of(ApplicationController).to receive(:current_user_name).and_return("Duke")
    allow(DateTime).to receive(:current).and_return('2021-11-06T00:14:46:00:00'.to_date)
  end

  it 'has a form to give a ranking and apply to meals' do
    visit meal_rating_path

    fill_in :rating, with: "8"

    # within "#meal-#{@meal1.id}" do
    #
    # end
  end
end
