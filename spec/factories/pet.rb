FactoryBot.define do
  
  factory :pet do
    name Faker::FunnyName.name
    monthly_cost Faker::Number.decimal(2)
    pet_kind
    association :owner, factory: 'person'
  end
end