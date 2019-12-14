class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def update_approval_status
    if !approval_status
      approval_status = true
    else
      approval_status = false
    end
  end
end
