class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    #keys = @favorites.keys.to_i
    #@pets = Pet.where(id: [keys])
  end

  def update

  pet = Pet.find(params[:id])
  if @favorites.content.keys.include?(pet.id.to_s)
    flash[:error] = "You have already favorited this pet!"
  else
    @favorites.add_favorite(pet.id)
    session[:favorite] = @favorites.content
    flash[:success] = "You added a new pet to your favorites!"
  end
   redirect_to "/pets/#{pet.id}"
  end

end
