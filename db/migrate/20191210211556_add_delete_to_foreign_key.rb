class AddDeleteToForeignKey < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :pet_applications, :pets
    add_foreign_key :pet_applications, :pets, on_delete: :cascade
  end
end
