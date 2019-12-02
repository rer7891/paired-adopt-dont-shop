class ChangeColumnstoNotNullinAllTables < ActiveRecord::Migration[5.1]
  def change
    change_column_null :shelters, :name, false
    change_column_null :shelters, :address, false
    change_column_null :shelters, :city, false
    change_column_null :shelters, :state, false
    change_column_null :shelters, :zip_code, false
    change_column_null :pets, :image_url, false
    change_column_null :pets, :name, false
    change_column_null :pets, :approximate_age, false
    change_column_null :pets, :sex, false
    change_column_null :pets, :description, false
    change_column_null :pets, :is_adoptable, false
  end
end
