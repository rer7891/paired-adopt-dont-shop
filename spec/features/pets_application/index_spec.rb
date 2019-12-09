require 'rails_helper'

RSpec.describe "Favorites Index Page", type: :feature do
  describe "As a visitor" do
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

      @shelter_2 = Shelter.create!(name: 'Pokemon Center of the Rockies',
                                    address: '12345 Colorado Blvd',
                                    city: 'Denver',
                                    state: 'CO',
                                    zip_code: '80014')

      @pikachu = @shelter_2.pets.create!(image_url: '/',
                                    name: 'Pikachu Chu',
                                    description: 'I am an electric type Pokemon.',
                                    approximate_age: 2,
                                    sex: 'F',
                                    favorite_status: true
                                    )

      @dog_2 = @shelter_1.pets.create!(image_url: '/',
                         name: 'Butter',
                         approximate_age: 4,
                         sex: 'M',
                         description: 'I am a golden retriever who loves to play fetch.'
                         )

      @application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                                         address: "12342 Main Street",
                                                         city: "Broomfield",
                                                         state: "CO",
                                                         zip: "34533",
                                                         phone_number: "43253424324",
                                                         description: "I will be a good dog parent.")



      @application_2 = @dog_2.applications.create!(name: "Linda Le",
                                                         address: "12342 Main Street",
                                                         city: "Broomfield",
                                                         state: "CO",
                                                         zip: "34533",
                                                         phone_number: "43253424324",
                                                         description: "I will be a good dog parent.")
       @application_2.pets << @dog_1
    end

    it "can see all applications for a certain pet" do
      application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                                 address: "12342 Main Street",
                                                 city: "Broomfield",
                                                 state: "CO",
                                                 zip: "34533",
                                                 phone_number: "43253424324",
                                                 description: "I will be a good dog parent.")

       application_2 = @dog_1.applications.create!(name: "Linda Le",
                                                    address: "12345 Union St",
                                                    city: "Lakewood",
                                                    state: "CO",
                                                    zip: "80228",
                                                    phone_number: "7201234567",
                                                    description: "I love dogs.")

        visit "/pets/#{@dog_1.id}"

        expect(page).to have_link('View All Applications for this Pet')
        click_on('View All Applications for this Pet')

        expect(page).to have_content(application_1.name)
        expect(page).to have_content(application_2.name)

        click_on("#{application_1.name}")
        expect(current_path).to eql("/applications/#{application_1.id}")
        visit "/pets/#{@dog_1.id}"
        click_on('View All Applications for this Pet')
        click_on("#{application_2.name}")
        expect(current_path).to eql("/applications/#{application_2.id}")
    end

    it 'will show a no applications message if no applications for that pet' do

       visit "/pets/#{@pikachu.id}"

       expect(page).to have_link('View All Applications for this Pet')
       click_on('View All Applications for this Pet')

       expect(page).to have_content('No applications have been submitted for this pet.')

     end
   end
end
