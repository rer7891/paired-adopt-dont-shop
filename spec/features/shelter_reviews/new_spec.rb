# require 'rails_helper'
#
# RSpec.describe "As a visitor", type: :feature do
#   describe "I can go to a shelter's show page" do
#     describe "and see a link to create a new review" do
#       xit "which takes me to a form where I can create a new review" do
#         @shelter_1 = Shelter.create!(name: 'Denver Pet Shelter',
#                                    address: '123 Colfax Ave',
#                                    city: 'Denver',
#                                    state: 'CO',
#                                    zip_code: '80004')
#         visit "/shelters/#{@shelter_1.id}"
#
#         click_link "Create A New Review"
#
#         expect(current_path).to eql("/shelters/#{@shelter_1.id}/reviews/new")
#         fill_in "Title"     with: "Best New Shelter"
#         fill_in "Rating"    with: 5
#         fill_in "Content"   with: "A brand new facility that is first rate. Their staff is friendly and helpful."
#         fill_in "Image_Url" with: "https://i.etsystatic.com/21148196/r/il/fcb7b9/2150670743/il_1588xN.2150670743_35qp.jpg"
#       end
#     end
#   end
# end
