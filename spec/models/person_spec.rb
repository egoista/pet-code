require 'rails_helper'

RSpec.describe Person, :type => :model do
  it "People can have pets" do
    person = create(:person)
    person.pets << build_list(:pet, 2, owner: nil)

    expect(person.valid?)
    expect(person.pets.count).to be 2
  end

  it "People must have more than 18 to have swallows" do
    young = create(:person, birthdate: 17.years.ago.to_date)
    adult = create(:person, birthdate: 18.years.ago.to_date)
    swallow = create(:pet_kind, name: 'andorinha')
    pet = build(:pet, owner: nil, pet_kind: swallow)

    young.pets << pet
    adult.pets << pet

    expect(young.valid?).to be_falsey
    expect(young.errors.messages[:pets]).to eq ['Person under 18 cannot have swallows']
    expect(adult.valid?)
  end

  it "People must not have initial latter A to have cats" do
    a_name = create(:person, name: 'Axl')
    not_a_name = create(:person, name: 'Joe')
    cat = create(:pet_kind, name: 'gato')
    pet = build(:pet, owner: nil, pet_kind: cat)

    a_name.pets << pet
    not_a_name.pets << pet

    expect(a_name.valid?).to be_falsey
    expect(a_name.errors.messages[:pets]).to eq ['Person with initial latter A cannot have cats']
    expect(not_a_name.valid?)
  end

  it "People cannot expend monthly more than 1000 with pets" do
    person_under_limit = create(:person)
    person_above_limit = create(:person)
    
    person_under_limit.pets << build_list(:pet, 2, monthly_cost: 500.0)
    person_above_limit.pets << build_list(:pet, 2, monthly_cost: 501.0)

    expect(person_under_limit.valid?)
    expect(person_above_limit.valid?).to be_falsey
    expect(person_above_limit.errors.messages[:pets]).to eq ['Monthly cost with pets above limit']
  end
end