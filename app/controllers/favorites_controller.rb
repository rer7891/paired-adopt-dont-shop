class FavoritesController < ApplicationController
  def index
    @favorite_pets = Pet.where("favorite_status = true")
  end

  def update
   @pet = Pet.find(params[:id])
   if @pet.favorite_status == false
     @pet.update(favorite_status: true)
     flash[:success] = "You added a new pet to your favorites!"
   else
     flash[:error] = "You have already favorited this pet!"
   end
   redirect_to "/pets/#{@pet.id}"
  end
end
