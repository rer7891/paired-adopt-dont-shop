require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "Show all applications on pets show page" do
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

    @application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                               address: "12342 Main Street",
                                               city: "Broomfield",
                                               state: "CO",
                                               zip: "34533",
                                               phone_number: "43253424324",
                                               description: "I will be a good dog parent.")

     @application_2 = @dog_1.applications.create!(name: "Linda Le",
                                                  address: "12345 Union St",
                                                  city: "Lakewood",
                                                  state: "CO",
                                                  zip: "80228",
                                                  phone_number: "7201234567",
                                                  description: "I love dogs.")
    end

    it 'can see all the applications for a pet' do
      visit "/pets/#{@dog_1.id}"

      expect(page).to have_link('View All Applications for this Pet')
      click_on('View All Applications for this Pet')

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_2.name)

      click_on("#{@application_1.name}")
      expect(current_path).to eql("/applications/#{@application_1.id}")
      visit "/pets/#{@dog_1.id}"
      click_on('View All Applications for this Pet')
      click_on("#{@application_2.name}")
      expect(current_path).to eql("/applications/#{@application_2.id}")
      save_and_open_page
    end
  end
end
