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

      @dog_2 = @shelter_1.pets.create!(image_url: '/',
                          name: 'Kuma',
                          description: 'I am an energetic, black Shiba Inu.',
                          approximate_age: 1,
                          sex: 'F',
                          favorite_status: false
                          )

    end

    it 'can delete a pet' do

      visit "pets/#{@dog_1.id}"

      click_on 'Delete Pet'

      assert_equal "/pets", current_path

      expect(page).to_not have_content(@dog_1.name)
      expect(page).to_not have_content(@dog_1.description)
      expect(page).to_not have_content(@dog_1.approximate_age)
      expect(page).to_not have_content("Gender: #{@dog_1.sex}")
    end
    it "when a pet is deleted it is also removed from favorites" do
      visit "/pets/#{@dog_1.id}"
      click_on 'Favorite This Pet'
      visit "/pets/#{@dog_2.id}"
      click_on 'Favorite This Pet'

      visit "/pets/#{@dog_1.id}"
      click_on 'Delete Pet'
      assert_equal "/pets", current_path

      expect(page).to have_content(@dog_2.name)
      expect(page).to_not have_content(@dog_1.name)
      expect(page).to have_content("Favorites: (1)")

      visit '/favorites'
      expect(page).to have_link("#{@dog_2.name}")
      expect(page).to_not have_link("#{@dog_1.name}")
    end
    it "will not delete a pet if there is a pending application." do
      application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                                         address: "12342 Main Street",
                                                         city: "Broomfield",
                                                         state: "CO",
                                                         zip: "34533",
                                                         phone_number: "43253424324",
                                                         description: "I will be a good dog parent.")
      visit "/applications/#{application_1.id}"

      click_on("Approve Application for #{@dog_1.name}")
      expect(current_path).to eql("/pets/#{@dog_1.id}")

      click_on 'Delete Pet'
      expect(current_path).to eql("/pets/#{@dog_1.id}")
      expect(page).to have_content("This pet currently has a pending adoption and cannot be removed at this time.")
      expect(page).to have_content(@dog_1.name)
    end
  end
end
