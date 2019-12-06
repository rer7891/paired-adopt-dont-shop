require 'rails_helper'

RSpec.describe "As a visitor when I visit /favorites", type: :feature do
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
  describe "I see a link for adopting my favorite pets" do
    it "when I click that link I see a form" do
        visit "pets/#{@dog_1.id}"
        click_on 'Favorite This Pet'
        visit "/pets/#{@dog_2.id}"
        click_on 'Favorite This Pet'
        visit '/favorites'

        click_on "Apply To Adopt Pet(s)"
        expect(current_path).to eql("/applications/new")
   end
      it "where I can select multiple pets and fill in personal details" do
        visit '/applications/new'

        fill_in 'Name',         with: "Becky Robran"
        fill_in 'Address',      with: '123 Main Street'
        fill_in 'City',         with: 'Lakewood'
        fill_in 'State',        with: 'CO'
        fill_in 'Zip',          with: 80023
        fill_in 'Phone Number'  with: '423-316-2121'
        fill_in 'Description'   with: 'Loving and work from home. I would give a great home.'
        click_button 'Submit Application'
      end
      it "when I sumbit my form I'm taken back to favorites wher I no longer see the pets" do
        visit '/favorites'

        expect(page).to_not have_content("#{@dog_1.name}")
        expect(page).to_not have_content("#{@dog_2.name}")

        expect(page).to have_content("Your application was recieved!")
      end
  end
end
