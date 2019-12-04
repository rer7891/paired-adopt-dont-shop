class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
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
