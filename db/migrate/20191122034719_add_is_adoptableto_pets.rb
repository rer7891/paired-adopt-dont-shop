class AddIsAdoptabletoPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :is_adoptable, :boolean
  end
end
