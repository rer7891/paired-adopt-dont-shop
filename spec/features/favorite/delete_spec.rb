require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I favorite a pet I see a new link to remove that pet from favorites" do
    describe "when I click that link I send a delete request to /favorites/:pet_id  " do
      it "and I'm redirected to pets show page where I see a flash message inidacting it's been removed" do
        shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                     address: '123 Colfax Ave',
                                     city: 'Denver',
                                     state: 'CO',
                                     zip_code: '80004')

        dog_1 = shelter_1.pets.create!(image_url: '/',
                             name: 'Tofu',
                             description: 'I am a neutered male, white Terrier Mix who loves to play fetch.',
                             approximate_age: 4,
                             sex: 'M',
                             favorite_status: true
                             )

         dog_2 = shelter_1.pets.create!(image_url: '/',
                            name: 'Kuma',
                            description: 'I am an energetic, black Shiba Inu.',
                            approximate_age: 1,
                            sex: 'F',
                            favorite_status: false
                            )

          visit "/pets/#{dog_1.id}"

          click_on 'Favorite This Pet'
          expect(page).to have_content("Favorites: (1)")

          visit "/pets/#{dog_1.id}"

          click_on "Delete This Pet From Favorites"

          expect(current_path).to eql("/pets/#{dog_1.id}")
          expect(page).to have_content("Favorites: (0)")

          expect(page).to have_content("You have removed this pet from favorites.")
      end
    end
  end
end
