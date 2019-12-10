class PetsController < ApplicationController
  layout 'application'

  def index
    @pets = Pet.all
  end

  def list_by_shelter
    @shelter = Shelter.find(params[:id])
    @pets = @shelter.pets.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
    @pet = Pet.new(pet_params)
  end

  def create
    @shelter = Shelter.find(params[:id])
    @pet = @shelter.pets.create(pet_params)
      if @pet.save
        flash[:notice] = "You have successfully added this pet!"
        redirect_to "/shelters/#{@shelter.id}/pets"
      else
        flash[:alert] = "You have not filled in all the necessary fields to create a pet"
        render 'new'
      end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
      if @pet.save
        flash[:notice] = "You have successfully edited this pet listing!"
        redirect_to "/pets/#{@pet.id}"
      else
        flash[:alert] = "You have not filled in all the necessary fields to edit the pet listing."
        render 'edit'
      end
  end

  def destroy
    pet = Pet.find(params[:id])
    if @favorites.include?(pet.id)
      @favorites.favorite_delete([pet])
      session[:favorite] = @favorites.content
    end
    if !pet.is_adoptable
      flash[:error] = "This pet currently has a pending adoption and cannot be removed at this time."
      redirect_to "/pets/#{pet.id}"
    else
      Pet.destroy(pet.id)
      redirect_to '/pets'
    end

  end

  private
    def pet_params
      params.permit(:image_url, :name, :approximate_age, :description, :sex)
    end
end
