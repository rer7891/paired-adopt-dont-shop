class ReviewsController < ApplicationController

  def new
  end

  def create
    shelter = Shelter.find(params[:id])
    #flash messages for users once a review is created.
    review = shelter.reviews.new(review_params)
      if review.save
        flash[:notice] = "You have created a review!"
        redirect_to "/shelters/#{shelter.id}"
     else
      flash[:alert] = "You have not filled in all the necessary fields to create a review."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
     end
  end

  def edit
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image_url)
  end
end
