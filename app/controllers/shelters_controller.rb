class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def create
    shelter = Shelter.new(shelter_params)
    shelter.save
    redirect_to '/shelters'
  end

  def new
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.adoptable_pets? 
      flash[:message] = "This shelter has pets with adoptions pending. You cannot delete it at this moment."
      redirect_to "/shelters/#{shelter.id}"
    else
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip_code)
  end
end
