FactoryBot.define do
  
  factory :pet_kind do
    name Faker::Creature::Animal.name
  end
end