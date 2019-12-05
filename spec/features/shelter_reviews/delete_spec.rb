require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'After visiting a shelters show page' do
    before :each do

      @shelter_1 = Shelter.create(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')

      @review_1 = Review.create!(title: 'Denver Pet Adoption Process',
                                 rating: 4,
                                 content: 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.',
                                 image_url: "https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg",
                                 shelter: @shelter_1)
    end

    it 'can delete shelter reviews from shelter show page' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Delete This Review')
      click_on('Delete This Review')

      expect(current_path).to eq "/shelters/#{@shelter_1.id}"

      expect(page).to_not have_content(@review_1.title)
      expect(page).to_not have_content(@review_1.content)

    end
  end
end
