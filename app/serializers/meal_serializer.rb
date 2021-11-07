class MealSerializer
  include JSONAPI::Serializer

  attributes :name, :rank, :foods, :meal_time
end
