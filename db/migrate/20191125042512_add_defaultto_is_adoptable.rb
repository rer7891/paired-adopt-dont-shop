class AddDefaulttoIsAdoptable < ActiveRecord::Migration[5.1]
  def up
    change_column :pets, :is_adoptable, :boolean, default: true
  end
end
