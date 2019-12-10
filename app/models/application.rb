class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description

  def update_approval_status
    if !approval_status
      approval_status = true
    else
      approval_status = false
    end 
  end

end
