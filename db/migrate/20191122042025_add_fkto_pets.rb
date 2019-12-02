class AddFktoPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :shelter_id, :integer
    add_foreign_key :pets, :shelters, on_delete: :cascade
  end
end
