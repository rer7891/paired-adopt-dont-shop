class FavoritesController < ApplicationController
  def index
  end

  def update
  pet_id = params[:id]

  if @favorites.content.key?(pet_id)
    flash[:error] = "You have already favorited this pet!"
  else
    @favorites.add_favorite(pet_id)
    session[:favorite] = @favorites.content
    flash[:success] = "You added a new pet to your favorites!"
  end
   redirect_to "/pets/#{pet_id}"
  end

end
