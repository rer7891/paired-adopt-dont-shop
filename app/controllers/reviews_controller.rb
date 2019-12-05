class ReviewsController < ApplicationController

  def new
  end

  def create
    shelter = Shelter.find(params[:id])
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

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter.id}"
    else
      flash[:notice] = "Title, review, and rating are required. Please try again!"
      redirect_to "/reviews/#{review.id}/edit"
    end
  end

  def destroy
    review = Review.find(params[:id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image_url)
  end
end
