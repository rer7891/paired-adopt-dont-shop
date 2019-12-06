class FavoritesController < ApplicationController
  def index
    @pets = Pet.where(id: [@favorites.keys])
  end

  def update
  pet = Pet.find(params[:id])
  if @favorites.include?(pet.id)
    flash[:error] = "You have already favorited this pet!"
  else
    @favorites.add_favorite(pet.id)
    session[:favorite] = @favorites.content
    flash[:success] = "You added a new pet to your favorites!"
  end
   redirect_to "/pets/#{pet.id}"
  end

  def destroy
    if params[:id] == nil
      @favorites = session.clear
    else
    @favorites.favorite_delete(params[:id])
    session[:favorite] = @favorites.content
    flash[:success] = "You have removed this pet from favorites."
    end
    redirect_back fallback_location: @post
  end

end
