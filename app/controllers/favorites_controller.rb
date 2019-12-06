class FavoritesController < ApplicationController
  def index
    keys = @favorites.content.map {|key, value| key.to_i }
    @pets = Pet.where(id: [keys])
    # have a model method that takes the contents from  @favorites and iterates through and turns them into pet objects
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
