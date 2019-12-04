require 'rails_helper'

RSpec.describe 'Favorites Index', type: :feature do
  describe 'As a visitor' do
    before :each do

    @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')

    @dog_1 = @shelter_1.pets.create!(image_url: '/',
                         name: 'Tofu',
                         description: 'I am a neutered male, white Terrier Mix who loves to play fetch.',
                         approximate_age: 4,
                         sex: 'M',
                         favorite_status: true
                         )

     @dog_2 = @shelter_1.pets.create!(image_url: '/',
                        name: 'Kuma',
                        description: 'I am an energetic, black Shiba Inu.',
                        approximate_age: 1,
                        sex: 'F',
                        favorite_status: false
                        )
    end

   xit 'can see all the favorite pets' do

      visit "pets/#{@dog_1.id}"

      click_on 'Favorite This Pet'

      visit "/pets/#{@dog_2.id}"

      click_on 'Favorite This Pet'

      visit '/favorites'

      expect(page).to have_link("#{@dog_1.name}")
      click_on ("#{@dog_1.name}")
      expect(current_path).to eq "/pets/#{@dog_1.id}"

      visit '/favorites'
      expect(page).to have_link("#{@dog_2.name}")
      click_on ("#{@dog_2.name}")
      expect(current_path).to eq "/pets/#{@dog_2.id}"
      expect(page).to have_xpath("//img[@src='#{@dog_1.image_url}']")
      expect(page).to have_xpath("//img[@src='#{@dog_2.image_url}']")
    end
  end
end
