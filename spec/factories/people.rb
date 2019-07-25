FactoryBot.define do
  
  factory :person do
    name Faker::Name.name
    document Faker::DrivingLicence.uk_driving_licence
    birthdate Faker::Date.birthday
  end
end