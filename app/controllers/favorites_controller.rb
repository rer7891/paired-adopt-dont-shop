class FavoritesController < ApplicationController
  def index
    ids = cookies[:favorites].split(",").uniq
    @favorite_pets = Pet.find(ids)
    @favorite_count = @favorite_pets.length
  end

  def update
   pet_id = params[:id]
   cookies[:favorites] += "#{pet_id},"
    flash[:success] = "You added a new pet to your favorites!"
   # else
   #   flash[:error] = "You have already favorited this pet!"
   # end

   redirect_to "/pets/#{pet_id}"
  end
end
