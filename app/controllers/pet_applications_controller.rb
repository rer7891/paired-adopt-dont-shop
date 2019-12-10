class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    @applications = @pet.applications.all
  end

  def update
    pet = Pet.find(params[:id])
    application = Application.find(params[:application_id])
      if params[:revoke]
        pet_helper(pet)
        application_helper(application)
        redirect_to "/applications/#{application.id}"
      elsif pet.is_adoptable
        pet_helper(pet)
        application_helper(application)
        redirect_to "/pets/#{pet.id}"
      else
        flash[:error] = "No more applications can be approved for this pet at this time."
        redirect_to "/pets/#{pet.id}"
      end
  end

  private
  def pet_params
    params.permit(:is_adoptable)
  end

  def app_params
    params.permit(:approval_status)
  end

  def application_helper(application)
    params[:approval_status] = application.update_approval_status
    application.update(app_params)
  end

  def pet_helper(pet)
    params[:is_adoptable] = pet.update_status
    pet.update(pet_params)
  end
end
