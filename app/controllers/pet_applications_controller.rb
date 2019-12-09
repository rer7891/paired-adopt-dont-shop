class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    @applications = @pet.applications.all
  end

  def update
    pet = Pet.find(params[:id])
    params[:is_adoptable] = pet.update_status
    pet.update(pet_params)
     if pet.save
       redirect_to "/pets/#{pet.id}"
     end
  end

  private
  def pet_params
    params.permit(:is_adoptable)
  end
end
