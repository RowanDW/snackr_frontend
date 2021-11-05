require 'rails_helper'

RSpec.describe BackendService do
  xit "can get meals for a user with a given date" do
    #Does this need a meal_time attribute?
    response = BackendService.get_meals

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Array

    first_meal = response[:data].first

    expect(first_meal).to have_key :id
    expect(first_meal[:id]).to be_a String

    expect(first_meal).to have_key :type
    expect(first_meal[:type]).to eq('meal')

    expect(first_meal).to have_key :attributes
    expect(first_meal[:attributes]).to be_a Hash

    expect(first_meal[:attributes]).to have_key :name
    expect(first_meal[:attributes][:name]).to be_a String

    expect(first_meal[:attributes]).to have_key :rank
    expect(first_meal[:attributes][:rank]).to be_a Integer

    expect(first_meal).to have_key :relationships
    expect(first_meal[:relationships]).to be_a Hash

    expect(first_meal[:relationships]).to have_key :food_entries
    expect(first_meal[:relationships][:food_entries]).to be_a Hash

    expect(first_meal[:relationships][:food_entries]).to have_key :data
    expect(first_meal[:relationships][:food_entries][:data]).to be_a Hash

    first_relationship = first_meal[:relationships][:food_entries][:data].first

    expect(first_relationship).to have_key :id
    expect(first_relationship[:id]).to be_a String

    expect(first_relationship).to have_key :name
    expect(first_relationship[:name]).to be_a String

    expect(first_relationship).to have_key :meal_id
    expect(first_relationship[:meal_id]).to be_a String

    expect(first_relationship).to have_key :food_id
    expect(first_relationship[:food_id]).to be_a String
  end

  xit "can create a new meal" do
    meal_hash = {
      "name": "Spaghetti",
      "user_id": 18,
      "meal_time": "2012-03-05, 00:00:00"
    }
    response = BackendService.new_meal(meal_hash)

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Hash

    meal = response[:data]

    expect(meal).to have_key :id
    expect(meal[:id]).to be_a String

    expect(meal).to have_key :type
    expect(meal[:type]).to eq('meal')

    expect(meal).to have_key :attributes
    expect(meal[:attributes]).to be_a Hash

    expect(meal[:attributes]).to have_key :name
    expect(meal[:attributes][:name]).to be_a String

    expect(meal[:attributes]).to have_key :rank
    expect(meal[:attributes][:rank]).to be_a Float

    expect(meal[:attributes]).to have_key :meal_time
    expect(meal[:attributes][:meal_time]).to be_a DateTime ## Or maybe String?
  end

  xit "can update a meal" do
    meal_hash = {
      "rank": 7,
      "meal_id": 18,
    }
    response = BackendService.update_meal(meal_hash)

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Hash

    meal = response[:data]

    expect(meal).to have_key :id
    expect(meal[:id]).to be_a String

    expect(meal).to have_key :type
    expect(meal[:type]).to eq('meal')

    expect(meal).to have_key :attributes
    expect(meal[:attributes]).to be_a Hash

    expect(meal[:attributes]).to have_key :name
    expect(meal[:attributes][:name]).to be_a String

    expect(meal[:attributes]).to have_key :rank
    expect(meal[:attributes][:rank]).to be_a Integer

    expect(meal[:attributes]).to have_key :meal_time
    expect(meal[:attributes][:meal_time]).to be_a DateTime ## Or maybe String?
  end

  xit "can get a list of a users ranked foods" do
    response = BackendService.get_foods

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Array

    first_food = response[:data].first

    expect(first_food).to have_key :id
    expect(first_food[:id]).to be_a String

    expect(first_food).to have_key :type
    expect(first_food[:type]).to eq('food_entry')

    expect(first_food).to have_key :attributes
    expect(first_food[:attributes]).to be_a Hash

    expect(first_food[:attributes]).to have_key :name
    expect(first_food[:attributes][:name]).to be_a String

    expect(first_food[:attributes]).to have_key :average_rank
    expect(first_food[:attributes][:average_rank]).to be_a Float
  end

  xit "can search for foods" do
    response = BackendService.food_search('hamburger+helper')

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Array

    first_food = response[:data].first

    expect(first_food).to have_key :id
    expect(first_food[:id]).to be_a String

    expect(first_food).to have_key :type
    expect(first_food[:type]).to eq('food')

    expect(first_food).to have_key :attributes
    expect(first_food[:attributes]).to be_a Hash

    expect(first_food[:attributes]).to have_key :name
    expect(first_food[:attributes][:name]).to be_a String
  end

  xit "can login a user" do
    response = BackendService.login_user('rowan@test.com', 'rowan', '12345')

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Hash

    expect(response[:data]).to have_key :id
    expect(response[:data][:id]).to be_a String

    expect(response[:data]).to have_key :type
    expect(response[:data][:type]).to eq('user')

    expect(response[:data]).to have_key :attributes
    expect(response[:data][:attributes]).to be_a Hash

    expect(response[:data][:attributes]).to have_key :name
    expect(response[:data][:attributes][:name]).to be_a String
  end
end
