require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "I can go to a shelter's show page" do
    describe "and see a link to create a new review" do
      it "which takes me to a form where I can create a new review" do
        shelter_1 = Shelter.create!(name: 'Denver Pet Shelter',
                                   address: '123 Colfax Ave',
                                   city: 'Denver',
                                   state: 'CO',
                                   zip_code: '80004')
        visit "/shelters/#{shelter_1.id}"

        click_link "Create A New Review"

        expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/new")

        fill_in :title,     with: "Best New Shelter"
        select('4', :from => 'Rating')
        fill_in :content,   with: "A brand new facility that is first rate. Their staff is friendly and helpful."
        fill_in :image_url, with: "https://picsum.photos/id/200/1920/1280"
        find('#review-button', :visible => false).click


        expect(current_path).to eql("/shelters/#{shelter_1.id}")

        expect(page).to have_content("You have created a review!")
        review = Review.last
        expect(review.title).to eql("Best New Shelter")
        expect(page).to have_content(review.title)
        expect(page).to have_content(review.rating)
        expect(page).to have_content(review.content)
      end

      it "will redirect to shelters/:id/reviews/new if a form is not fill out completely" do
        shelter_1 = Shelter.create!(name: 'Denver Pet Shelter',
                                   address: '123 Colfax Ave',
                                   city: 'Denver',
                                   state: 'CO',
                                   zip_code: '80004')
        visit "/shelters/#{shelter_1.id}"

        click_link "Create A New Review"

        expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/new")

        #There is no title or rating filled in.
        fill_in :content,   with: "A brand new facility that is first rate. Their staff is friendly and helpful."
        fill_in :image_url, with: "https://picsum.photos/id/200/1920/1280"
        find('#review-button', :visible => false).click

        expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/new")
        expect(page).to have_content( "You have not filled in all the necessary fields to create a review.")
      end
      it 'assigns a default picture to the review if none is provided.' do
        shelter_1 = Shelter.create!(name: 'Denver Pet Shelter',
                                   address: '123 Colfax Ave',
                                   city: 'Denver',
                                   state: 'CO',
                                   zip_code: '80004')
        visit "/shelters/#{shelter_1.id}"

        click_link "Create A New Review"

        expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/new")

        fill_in :title,     with: "Best New Shelter"
        select('4', :from => 'Rating')
        fill_in :content,   with: "A brand new facility that is first rate. Their staff is friendly and helpful."
        find('#review-button', :visible => false).click

        expect(current_path).to eql("/shelters/#{shelter_1.id}")

        review = Review.last
        expect(review.image_url).to eql("https://naturewatch.org/files/uploads/o-ANIMAL-SHELTER-facebook.jpg")

      end
    end
  end
end
