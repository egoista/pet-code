class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.float :monthly_cost
      t.integer :kind
      t.belongs_to :owner, foreign_key: {to_table: :people}
      t.belongs_to :pet_kind, foreign_key: true

      t.timestamps
    end
  end
end
