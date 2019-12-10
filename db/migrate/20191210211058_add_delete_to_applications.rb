class AddDeleteToApplications < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :pet_applications, :applications
    add_foreign_key :pet_applications, :applications, on_delete: :cascade
  end
end
