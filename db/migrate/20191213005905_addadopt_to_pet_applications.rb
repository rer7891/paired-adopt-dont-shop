class AddadoptToPetApplications < ActiveRecord::Migration[5.1]
  def change
      add_column :pet_applications, :approval_status, :boolean, default: false
  end
end
