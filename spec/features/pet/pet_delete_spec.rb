require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'After visiting a pets show page and clicking on delete that pet' do
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
                         )

    end

    it 'can delete a pet' do

      visit "pets/#{@dog_1.id}"

      click_on 'Delete Pet'

      assert_equal "/pets", current_path

      expect(page).to_not have_content(@dog_1.name)
      expect(page).to_not have_content(@dog_1.description)
      expect(page).to_not have_content(@dog_1.approximate_age)
      expect(page).to_not have_content(@dog_1.sex)

    end
  end
end
