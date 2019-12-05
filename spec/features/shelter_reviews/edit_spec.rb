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

    it 'can edit shelter reviews with a prepopulated form' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Edit This Review')

      click_on 'Edit This Review'

      expect(find_field('title').value).to eq 'Denver Pet Adoption Process'
      expect(find_field('content').value).to eq 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.'
      expect(find_field('image_url').value).to eq 'https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg'
      expect(page).to have_content('Rating')

      select('5', :from => 'Rating')
      fill_in 'title',   with: 'Great Adoption Process'

      expect(page).to have_button('Submit')

      click_on('Submit')
      expect(current_path).to eq "/shelters/#{@shelter_1.id}"

      expect(page).to have_content('5 stars')
      expect(page).to have_content('Great Adoption Process')

    end

    it 'can edit shelter reviews and will display a flash message if any info but image url is missing' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Edit This Review')

      click_on 'Edit This Review'

      expect(find_field('title').value).to eq 'Denver Pet Adoption Process'
      expect(find_field('content').value).to eq 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.'
      expect(find_field('image_url').value).to eq 'https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg'
      expect(page).to have_content('Rating')

      select('5', :from => 'Rating')
      fill_in 'title',   with: ' '
      fill_in 'content', with: ' '

      expect(page).to have_button('Submit')

      click_on('Submit')
      expect(page).to have_content('Title, review, and rating are required. Please try again!')

    end
  end
end
