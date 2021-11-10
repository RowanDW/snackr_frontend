require 'rails_helper'

RSpec.describe BackendService do
  it "can get meals for a user with a given date", :vcr do
    # {
    #   "data": [
    #     {
    #       "id": "1",
    #       "type": "meal",
    #       "attributes": {
    #         "name": "Avocado toast",
    #         "rank": 8,
    #         "meal_time": "2012-03-05, 00:00:00"
    #       },
    #       "relationships": {
    #         "food_entries": {
    #           "data": [
    #             {
    #               "id": 1,
    #               "meal_id": 1,
    #               "food_id": 12345,
    #               "name": "bread"
    #             },
    #             {
    #               "id": 2,
    #               "meal_id": 1,
    #               "food_id": 68762,
    #               "name": "avocado"
    #             }
    #           ]
    #         }
    #       }
    #     }
    #   ]
    # }
    response = BackendService.get_meals(6, "2021-11-06 08:30:00")

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Array

    first_meal = response[:data].first

    expect(first_meal).to have_key :id
    expect(first_meal[:id]).to be_a Integer

    expect(first_meal).to have_key :type
    expect(first_meal[:type]).to eq('meal')

    expect(first_meal).to have_key :attributes
    expect(first_meal[:attributes]).to be_a Hash

    expect(first_meal[:attributes]).to have_key :name
    expect(first_meal[:attributes][:name]).to be_a String

    expect(first_meal[:attributes]).to have_key :rank
    expect(first_meal[:attributes][:rank]).to be_a Integer

    expect(first_meal[:attributes]).to have_key :meal_time
    expect(first_meal[:attributes][:meal_time]).to be_a String

    expect(first_meal).to have_key :relationships
    expect(first_meal[:relationships]).to be_a Hash

    expect(first_meal[:relationships]).to have_key :food_entries
    expect(first_meal[:relationships][:food_entries]).to be_a Hash

    expect(first_meal[:relationships][:food_entries]).to have_key :data
    expect(first_meal[:relationships][:food_entries][:data]).to be_a Array

    first_relationship = first_meal[:relationships][:food_entries][:data].first

    expect(first_relationship).to have_key :id
    expect(first_relationship[:id]).to be_a Integer

    expect(first_relationship).to have_key :food_name
    expect(first_relationship[:food_name]).to be_a String

    expect(first_relationship).to have_key :meal_id
    expect(first_relationship[:meal_id]).to be_a Integer

    expect(first_relationship).to have_key :food_id
    expect(first_relationship[:food_id]).to be_a String
  end

  it "can create a new meal", :vcr do
    lasagna = File.read('spec/fixtures/responses/lasagna.json')
    response = BackendService.new_meal(6, lasagna)

    # {
    #   "data": {
    #     "id": "12",
    #     "type": "meal",
    #     "attributes": {
    #       "name": "Spaghetti",
    #       "meal_time": "2012-03-05, 00:00:00",
    #       "rank": -1
    #     }
    #   }
    # }
    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Hash

    meal = response[:data]

    expect(meal).to have_key :id
    expect(meal[:id]).to be_a Integer

    expect(meal).to have_key :type
    expect(meal[:type]).to eq('meal')

    expect(meal).to have_key :attributes
    expect(meal[:attributes]).to be_a Hash

    expect(meal[:attributes]).to have_key :name
    expect(meal[:attributes][:name]).to be_a String

    expect(meal[:attributes]).to have_key :rank
    expect(meal[:attributes][:rank]).to eq(-1)

    expect(meal[:attributes]).to have_key :meal_time
    expect(meal[:attributes][:meal_time].to_datetime).to be_a DateTime
    expect(meal[:attributes][:meal_time].to_datetime).to be_a DateTime
  end

  it "can update a meal", :vcr do
    meal_hash = {
      "rank": 1,
      "meal_id": 1
    }
    response = BackendService.update_meal(6, meal_hash)
    #
    # {
    #   "data": {
    #     "id": "12",
    #     "type": "meal",
    #     "attributes": {
    #       "name": "Spaghetti",
    #       "meal_time": "2012-03-05, 00:00:00",
    #       "rank": 7
    #     }
    #   }
    # }
    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Hash

    meal = response[:data]

    expect(meal).to have_key :id
    expect(meal[:id]).to be_a Integer

    expect(meal).to have_key :type
    expect(meal[:type]).to eq('meal')

    expect(meal).to have_key :attributes
    expect(meal[:attributes]).to be_a Hash

    expect(meal[:attributes]).to have_key :name
    expect(meal[:attributes][:name]).to be_a String

    expect(meal[:attributes]).to have_key :rank
    expect(meal[:attributes][:rank]).to be_a Integer

    expect(meal[:attributes]).to have_key :meal_time
    expect(meal[:attributes][:meal_time]).to be_a String ## Or maybe String?
  end

  it "can get a list of a users ranked foods", :vcr do
    response = BackendService.get_foods(6)
    # {
    #   "data": [
    #     {
    #       "id": "1",
    #       "type": "food_entry",
    #       "attributes": {
    #         "name": "Avocado",
    #         "average_rank": 8.5
    #       }
    #     },
    #     {
    #       "id": "8",
    #       "type": "food_entry",
    #       "attributes": {
    #         "name": "Chocolate",
    #         "average_rank": 8.3
    #       }
    #     }
    #   ]
    # }

    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_a Array

    first_food = response[:data].first

    expect(first_food).to have_key :type
    expect(first_food[:type]).to eq('food_entry')

    expect(first_food).to have_key :attributes
    expect(first_food[:attributes]).to be_a Hash

    expect(first_food[:attributes]).to have_key :name
    expect(first_food[:attributes][:name]).to be_a String

    expect(first_food[:attributes]).to have_key :average_rank
    expect(first_food[:attributes][:average_rank].to_f).to be_a Float
  end

  it "can search for foods", :vcr do
    response = BackendService.food_search('hamburger+helper')
    # {
    #   "data": [
    #     {
    #       "type": "food",
    #       "attributes": {
    #         "name": "Avocado",
    #         "food_id": "food_98u23mokdjfkbqkjsdfjk",
    #         "brand": "Haas"
    #       }
    #     },
    #     {
    #       "type": "food",
    #       "attributes": {
    #         "name": "Avocado",
    #         "food_id": "food_lkjasdf908uw3rkjbasfkh",
    #         "brand": "NotHaas"
    #       }
    #     }
    #   ]
    # }

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

    it "can login a user", :vcr do
    response = BackendService.login_user('rowantestcom', 'rowan', '12345')
    # {
    #   "data": {
    #     'id':  '1',
    #     'type': 'user',
    #     'attributes': {
    #       'name': "name"
    #     }
    #   }
    # }

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

  it 'can get graphs for a user', :vcr do
    response = BackendService.get_graphs(6)
    # {
    #    "data": [
        #     {
        #       "type": "graph",
        #       "attributes": {
        #         "name": "top_10",
        #         "uri": "/chart?blahblahblah"
        #       }
        #     },
        #     {
        #       "type": "graph",
        #       "attributes": {
        #         "name": "bottom_10",
        #         "uri": "/chart?blahblahblah"
        #       }
        #     }
        #   ]
        # }
    expect(response).to be_a Hash

    expect(response).to have_key :data
    expect(response[:data]).to be_an Array

    expect(response[:data].first).to have_key :type
    expect(response[:data].first[:type]).to eq('graph')

    expect(response[:data].first).to have_key :attributes
    expect(response[:data].first[:attributes]).to be_a Hash

    expect(response[:data].first[:attributes]).to have_key :name
    expect(response[:data].first[:attributes][:name]).to be_a String

    expect(response[:data].first[:attributes]).to have_key :uri
    expect(response[:data].first[:attributes][:uri]).to be_a String

  end
end
