class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    @applications = @pet.applications.all
  end

  def update
    pet = Pet.find(params[:id])
    application = Application.find(params[:application_id])
      if pet.is_adoptable
        params[:is_adoptable] = pet.update_status
        params[:approval_status] = application.update_approval_status
        pet.update(pet_params)
        pet.save
        application.update(app_params)
        application.save
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
end
