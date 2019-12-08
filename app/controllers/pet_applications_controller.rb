class PetApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    @applications = @pet.applications.all
  end

end
