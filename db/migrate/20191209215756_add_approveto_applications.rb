class AddApprovetoApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :approval_status, :boolean, default: false
  end
end
