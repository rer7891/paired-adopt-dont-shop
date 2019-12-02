class RemoveShelterNamefromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :shelter_name
  end
end
