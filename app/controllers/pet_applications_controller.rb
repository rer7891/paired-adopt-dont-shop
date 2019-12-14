class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    @applications = @pet.applications.all
  end

  def update
    pet = Pet.find(params[:id])
    application = Application.find(params[:application_id])
    pet_application = PetApplication.where(pet_id: params[:id], application_id: params[:application_id]).first
      if pet.is_adoptable
        pet_helper(pet)
        application_helper(pet_application)
        redirect_to "/pets/#{pet.id}"
      elsif params[:revoke] != nil
        pet_helper(pet)
        application_helper(pet_application)
        redirect_to "/applications/#{application.id}"
      end
  end

  private
  def pet_params
    params.permit(:is_adoptable)
  end

  def app_params
    params.permit(:approval_status)
  end

  def application_helper(pet_application)
    params[:approval_status] = pet_application.update_approval_status
    pet_application.update(app_params)
  end

  def pet_helper(pet)
    params[:is_adoptable] = pet.update_status
    pet.update(pet_params)
  end
end
