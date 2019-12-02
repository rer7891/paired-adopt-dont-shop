class AddConstrainttoSheltersZipCode < ActiveRecord::Migration[5.1]
  def change
    change_column :shelters, :zip_code, :string, limit: 5
  end
end
