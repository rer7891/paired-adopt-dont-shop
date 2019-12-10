require 'rails_helper'

RSpec.describe 'Shelter new page', type: :feature do
  describe 'As a visitor' do

    it 'can see links at top of page that go to pet and shelter indexes' do

      visit '/shelters/new'

      expect(page).to have_link('All Pets', href: '/pets')
      expect(page).to have_link('All Shelters', href: '/shelters')

    end

    it 'can create a shelter' do

      visit '/shelters'
      click_on 'Create New Shelter'

      name = 'Shelter Test'
      address = '123 Larimer Street'
      city = 'Denver'
      state = 'CO'
      zip_code = '80001'

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip_code, with: zip_code
      click_on 'Submit'

      new_shelter = Shelter.last
      assert_equal '/shelters', current_path

      expect(page).to have_content(name)
      expect(new_shelter.name).to eq(name)
      expect(new_shelter.address).to eq(address)
      expect(new_shelter.city).to eq(city)
      expect(new_shelter.state).to eq(state)
      expect(new_shelter.zip_code).to eq(zip_code)

    end

    it 'can see error messages stating which fields are missing' do
      visit '/shelters'
      click_on 'Create New Shelter'

      name = 'Shelter Test'
      address = ''
      city = 'Denver'
      state = 'CO'
      zip_code = ''

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip_code, with: zip_code
      click_on 'Submit'

      expect(page).to have_content('3 errors prohibited this shelter from being saved:')
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("Zip code can't be blank")
      expect(page).to have_content('You have not filled in all the necessary fields to create a shelter.')
      expect(page).to have_content("Zip code is not valid - please enter a 5 digit zip code")

    end
  end
end
