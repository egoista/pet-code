require 'rails_helper'

RSpec.describe Person, :type => :model do
  it "People can have pets" do
    person = create(:person)
    person.pets << build_list(:pet, 2, owner: nil)

    expect(person.valid?).to be_truthy
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
    expect(adult.valid?).to be_truthy
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
    expect(not_a_name.valid?).to be_truthy
  end

  it "People cannot expend monthly more than 1000 with pets" do
    person_under_limit = create(:person)
    person_above_limit = create(:person)
    
    person_under_limit.pets << build_list(:pet, 2, monthly_cost: 500.0)
    person_above_limit.pets << build_list(:pet, 2, monthly_cost: 501.0)

    expect(person_under_limit.valid?).to be_truthy
    expect(person_above_limit.valid?).to be_falsey
    expect(person_above_limit.errors.messages[:pets]).to eq ['Monthly cost with pets above limit']
  end

  describe "#has_pet_kind?" do
    let(:person) { create(:person) }

    context "when pet kind with name paramater exists" do
      let(:pet_kind) { create(:pet_kind) }

      context "when person has pet with kind" do
        it "returns true" do
          create(:pet, owner: person, pet_kind: pet_kind)
          person.reload

          expect(person.has_pet_kind?(pet_kind.name)).to be_truthy
        end
      end

      context "when person has not pet with kind" do
        it "returns false" do
          expect(person.has_pet_kind?(pet_kind.name)).to be_falsey
        end
      end
    end

    context "when pet king with name paramater does not exsts" do
      it "returns false" do
        expect(person.has_pet_kind?("inexistent")).to be_falsey
      end
    end
  end

  describe "#age" do
    it "returns person's age" do
      one_year_person = create(:person, birthdate: Date.today - 2.year + 1.month)
      two_year_person = create(:person, birthdate: Date.today - 2.year - 1.month)

      expect(one_year_person.age).to eq 1
      expect(two_year_person.age).to eq 2
    end
  end

  describe "#pets_cost" do
    let(:person) { create(:person) }

    context "when person hasnt pets" do
      it "returns 0" do
        expect(person.pets_cost).to eq 0
      end
    end

    context "when person has pets" do
      it "returns sum of pets monthly_cost" do
        person.pets << create_list(:pet, 2, monthly_cost: 10)

        expect(person.pets_cost).to eq 20
      end
    end
  end
end