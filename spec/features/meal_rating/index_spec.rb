require 'rails_helper'

RSpec.describe 'visiting the meal rating page' do
  before :each do
    mock_response =
    {
      :data=>[
        {
          :id=>1,
          :type=>"meal",
          :attributes=> {
             :name=>"Spaghetti with Meatballs",
             :rank=>-1,
             :meal_time=>"2021-11-06T00:14:46:00:00"
          },
          :relationships=> {
            :food_entries=> {
              :data=> [
                 {
                   :id=>1,
                   :name=>"Meatballs",
                   :food_id=>123,
                   :average_rank=>nil
                 },
                 {
                   :id=>2,
                   :name=>"Spaghetti",
                   :food_id=>456,
                   :average_rank=>nil

                 }
               ]
            }
          }
        },
        {
          :id=>2,
          :type=>"meal",
          :attributes=> {
             :name=>"Breakfast Burrito",
             :rank=>-1,
             :meal_time=>"2021-11-06T00:14:46:00:00"
          },
          :relationships=> {
            :food_entries=> {
               :data=> [
               {
                 :id=>15,
                 :name=>"Eggs",
                 :food_id=>893472,
                 :average_rank=>nil
               },
               {
                 :id=>16,
                 :name=>"Tortilla",
                 :food_id=>349817,
                 :average_rank=>nil
                 }
              ]
            }
          }
        }
      ]
    }

    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return(1)
    allow_any_instance_of(ApplicationController).to receive(:current_user_name).and_return("Duke")
    allow(DateTime).to receive(:current).and_return('2021-11-06T00:14:46:00:00'.to_date)
    allow(BackendService).to receive(:get_meals).and_return(mock_response)
  end

  it 'has a form to give a ranking and apply to meals' do
    visit meal_rating_path
    save_and_open_page
    fill_in :rating, with: "8"
    
  end
end
