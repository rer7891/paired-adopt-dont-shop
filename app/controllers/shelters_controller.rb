class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def create
    @shelter = Shelter.create(shelter_params)
    if @shelter.save
      flash[:notice] = "You have successfully added this shelter."
      redirect_to "/shelters"
    else
      flash[:notice] = "You have not filled in all the necessary fields to create a shelter."
      render :new
    end
  end

  def new
    @shelter = Shelter.new(shelter_params)
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    if @shelter.save
      flash[:notice] = "You have successfully edited this shelter listing!"
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:alert] = "You have not filled in all the necessary fields to edit the shelter listing."
      render 'edit'
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.adoptable_pets?
      flash[:message] = "This shelter has pets with adoptions pending. You cannot delete it at this moment."
      redirect_to "/shelters/#{shelter.id}"
    else
      Shelter.destroy(params[:id])
      flash[:message] = "This shelter has been successfully removed."
      redirect_to '/shelters'
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip_code)
  end
end
