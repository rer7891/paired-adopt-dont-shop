require 'rails_helper'

RSpec.describe 'Shelter new page', type: :feature do
  describe 'As a visitor' do
    before :each do

      @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')
    end

    it 'can see links to pet and shelter index pages' do

      visit "/shelters/#{@shelter_1.id}/pets/new"

      expect(page).to have_link('All Pets', href: "/pets")
      expect(page).to have_link('All Shelters', href: "/shelters")

    end

    it 'can add a new adoptable pet to that shelter'  do

      visit "/shelters/#{@shelter_1.id}/pets"

      click_on('Add New Pet for Adoption')
      assert_equal "/shelters/#{@shelter_1.id}/pets/new", current_path

      fill_in 'image_url',        with: "https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/08/shiba-inu-detail.jpg"
      fill_in 'name',             with: 'Kuma'
      fill_in 'description',      with: 'Active Shiba Inu who enjoys long walks.'
      fill_in 'approximate_age',  with: 2
      fill_in 'sex',              with: 'F'
      click_button 'Submit'

      assert_equal "/shelters/#{@shelter_1.id}/pets", current_path

      expect(page).to have_xpath("//img[@src='https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/08/shiba-inu-detail.jpg']")
      expect(page).to have_content('Kuma')
      expect(page).to have_content('Active Shiba Inu who enjoys long walks.')
      expect(page).to have_content(2)
      expect(page).to have_content('F')
      expect(page).to have_content ('Adoptable')

    end

    it 'can see a flash message listing missing fields if new pet form is incomplete' do

      visit "/shelters/#{@shelter_1.id}/pets"

      click_on('Add New Pet for Adoption')
      assert_equal "/shelters/#{@shelter_1.id}/pets/new", current_path

      fill_in 'image_url',        with: "https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/08/shiba-inu-detail.jpg"
      fill_in 'name',             with: ''
      fill_in 'description',      with: 'Loving Shiba Inu Mix who enjoys chilling at home.'
      fill_in 'approximate_age',  with: ''
      fill_in 'sex',              with: 'F'
      click_button 'Submit'

      expect(page).to have_content('4 errors prohibited this pet from being saved:')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Approximate age can't be blank")
      expect(page).to have_content('You have not filled in all the necessary fields to create a pet')
      expect(page).to have_content("Name is required and must only contain letters")
      expect(page).to have_content("Approximate age must be a number")

    end
  end
end
