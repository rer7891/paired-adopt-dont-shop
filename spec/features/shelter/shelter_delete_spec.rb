require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'After visiting a shelters show page and clicking on delete that shelter' do
    before :each do

      @shelter_1 = Shelter.create(name: 'Denver Animal Shelter',
                                     address: '123 Colfax Ave',
                                     city: 'Denver',
                                     state: 'CO',
                                     zip_code: '80004')

    end

    it 'can delete an existing shelter' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Delete This Shelter')
      click_link 'Delete This Shelter'

      expect(current_path).to eq "/shelters"

      expect(page).to_not have_content(@shelter_1.name)
    end
  end
end
