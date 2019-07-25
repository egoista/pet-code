class Person < ApplicationRecord
  has_many :pets, foreign_key: 'owner_id'

  validate :age_restriction_for_swallow
  validate :initial_letter_restriction_for_cat
  validate :cost_limit

  def has_pet_kind?(pet_kind_name)
    pet_kind_id = PetKind.where(name: pet_kind_name).pluck(:id).first
    
    if pet_kind_id
      pets.any? { |pet| pet.pet_kind_id == pet_kind_id }
    else
      false
    end
  end

  def age
    # method extracted from https://github.com/kenn/age_calculator
    (Date.today.to_s(:number).to_i - birthdate.to_s(:number).to_i) / 10000
  end

  def pets_cost
    pets.map(&:monthly_cost).reduce(0, :+)
  end

  private

  def age_restriction_for_swallow
    if has_pet_kind?('andorinha') && age < 18
      errors.add(:pets, 'Person under 18 cannot have swallows')
    end
  end

  def initial_letter_restriction_for_cat
    if name[0] == 'A' && has_pet_kind?('gato')
      errors.add(:pets, 'Person with initial latter A cannot have cats')
    end
  end

  def cost_limit
    if pets_cost > 1000
      errors.add(:pets, 'Monthly cost with pets above limit')
    end
  end
end
