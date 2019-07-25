class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'Person' 
  belongs_to :pet_kind
end
