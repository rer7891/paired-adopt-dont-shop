require 'rails_helper'

RSpec.describe 'Navigation bar', type: :feature do
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

      end
    it 'can see a favorites link' do
      visit "/pets/#{@dog_1.id}"
      click_on "Favorite This Pet"

      visit '/'

      within 'nav' do
        expect(page).to have_link("Favorites: (1)")
        click_on("Favorites: (1)")
        expect(current_path).to eq "/favorites"
      end
    end 
  end
end
