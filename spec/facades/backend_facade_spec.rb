require 'rails_helper'

RSpec.describe 'BackendFacade' do
  it "#get_meals" do
    mock_response = {
        "data": [
          {
            "id": "1",
            "type": "meal",
            "attributes": {
              "name": "Avocado toast",
              "rank": 8,
              "meal_time": "2012-03-05, 00:00:00"
            },
            "relationships": {
              "food_entries": {
                "data": [
                  {
                    "id": 1,
                    "meal_id": 1,
                    "food_id": 12345,
                    "name": "bread"
                  },
                  {
                    "id": 2,
                    "meal_id": 1,
                    "food_id": 68762,
                    "name": "avocado"
                  }
                ]
              }
            }
          }
        ]
      }
    allow(BackendService).to receive(:get_meals).and_return(mock_response)

    meals = BackendFacade.get_meals(1)

    expect(meals).to be_a Array
    expect(meals.size).to eq(1)
    expect(meals.first).to be_a Meal
  end

  it "#get_foods" do
    mock_response = {
      "data": [
        {
          "id": "1",
          "type": "food_entry",
          "attributes": {
            "name": "Avocado",
            "average_rank": 8.5
          }
        },
        {
          "id": "8",
          "type": "food_entry",
          "attributes": {
            "name": "Chocolate",
            "average_rank": 8.3
          }
        }
      ]
    }

    allow(BackendService).to receive(:get_foods).and_return(mock_response)

    meals = BackendFacade.get_foods(1)

    expect(meals).to be_a Array
    expect(meals.size).to eq(2)
    expect(meals.first).to be_a FoodEntry
  end

  it "#food_search" do
    mock_response = {
      "data": [
        {
          "type": "food",
          "attributes": {
            "name": "Avocado",
            "food_id": "food_98u23mokdjfkbqkjsdfjk",
            "brand": "Haas"
          }
        },
        {
          "type": "food",
          "attributes": {
            "name": "Avocado",
            "food_id": "food_lkjasdf908uw3rkjbasfkh",
            "brand": "NotHaas"
          }
        }
      ]
    }
    allow(BackendService).to receive(:food_search).and_return(mock_response)

    meals = BackendFacade.food_search('avocado')

    expect(meals).to be_a Array
    expect(meals.size).to eq(2)
    expect(meals.first).to be_a Food
  end

  it "#login_user" do
    mock_response = {
      "data": {
        'id':  '1',
        'type': 'user',
        'attributes': {
          'name': "name"
        }
      }
    }

    allow(BackendService).to receive(:login_user).and_return(mock_response)

    meals = BackendFacade.login_user('rowan@test.com', 'rowan', '12345')

    expect(meals).to be_a String
  end

  it "#get_graphs" do
    mock_response = {
      "data": [
          {
            "type": "graph",
            "attributes": {
              "name": "top_10",
              "uri": "/chart?blahblahblah"
            }
          },
          {
            "type": "graph",
            "attributes": {
              "name": "bottom_10",
              "uri": "/chart?blahblahblah"
            }
          }
        ]
      }

    allow(BackendService).to receive(:get_graphs).and_return(mock_response)

    graphs = BackendFacade.get_graphs(1)

    expect(graphs).to be_a Hash
    expect(graphs.size).to eq(2)
  end
end
