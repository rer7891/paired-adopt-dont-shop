require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a shelter's show page" do
    describe "I will see a list of reviews for that shelter" do
      it "that includes title, rating, content, optional picture" do
        @shelter_1 = Shelter.create!(name: 'Denver Pet Shelter',
                                   address: '123 Colfax Ave',
                                   city: 'Denver',
                                   state: 'CO',
                                   zip_code: '80004')
        @review_1 = Review.create!(title: 'Denver Pet Adoption Process',
                                   rating: 4,
                                   content: 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.',
                                   image_url: "https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg",
                                   shelter: @shelter_1)
        @review_2 = Review.create!(title: 'Denver Pet Is the Best',
                                  rating: 5,
                                  content: 'Denver Pet Shelter helped us find a new family member. I can never thank them enough.',
                                  shelter: @shelter_1)
        @reviews = [@review_1, @review_2]
        visit "/shelters/#{@shelter_1.id}"

        @reviews.each do |review|
          expect(page).to have_content(review.title)
          expect(page).to have_content(review.rating)
          expect(page).to have_content(review.content)
        end

        expect(page).to have_xpath("//img[@src='https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg']")
      end
    end
  end
end
