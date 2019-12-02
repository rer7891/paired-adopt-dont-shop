require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'After visiting a shelters show page and clicking on edit that shelter' do
    before :each do

      @shelter_1 = Shelter.create(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')

    end

    it 'can see links to shelter id pages for all shelters listed' do

      visit "/shelters/#{@shelter_1.id}/edit"

      expect(page).to have_link('All Pets', href: '/pets')
      expect(page).to have_link('All Shelters', href: '/shelters')

    end

    it 'can see prepopulated info on that shelter in the form' do

        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_link('Update This Shelter')

        click_link 'Update This Shelter'

        expect(find_field('name').value).to eq 'Denver Animal Shelter'
        expect(find_field('address').value).to eq '123 Colfax Ave'
        expect(find_field('city').value).to eq 'Denver'
        expect(find_field('state').value).to eq 'CO'
        expect(find_field('zip_code').value).to eq '80004'

    end

    it 'can update shelter information through a form' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Update This Shelter')

      click_link 'Update This Shelter'
      expect(current_path).to eq "/shelters/#{@shelter_1.id}/edit"

      expect(page).to have_field('name')
      expect(page).to have_field('address')
      expect(page).to have_field('city')
      expect(page).to have_field('state')
      expect(page).to have_field('zip_code')

      fill_in 'name',      with: 'Shelter Example 1'
      fill_in 'address',   with: '987 Colorado Boulevard'

      expect(page).to have_button('Submit')

      click_on('Submit')
      expect(current_path).to eq "/shelters/#{@shelter_1.id}"

      expect(page).to have_content('Shelter Example 1')
      expect(page).to have_content('987 Colorado Boulevard')

    end
  end
end
