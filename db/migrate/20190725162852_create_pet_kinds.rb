class CreatePetKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_kinds do |t|
      t.string :name

      t.timestamps
    end
  end
end
