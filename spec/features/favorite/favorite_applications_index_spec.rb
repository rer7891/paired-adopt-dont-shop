require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "After one or more applications have been created" do
      before :each do
        @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                     address: '123 Colfax Ave',
                                     city: 'Denver',
                                     state: 'CO',
                                     zip_code: '80004')
        @dog = @shelter_1.pets.create!(image_url: '/',
                              name: 'Nutter',
                              description: 'I am a fluffy golden with lots of energy',
                              approximate_age: 2,
                              sex: 'F',
                              favorite_status: true
                              )

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
          visit "pets/#{@dog_1.id}"
          click_on 'Favorite This Pet'
          visit "/pets/#{@dog_2.id}"
          click_on 'Favorite This Pet'

          @application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                                     address: "12342 Main Street",
                                                     city: "Broomfield",
                                                     state: "CO",
                                                     zip: "34533",
                                                     phone_number: "43253424324",
                                                     description: "I will be a good dog parent.")
          @application_2 = @dog.applications.create!(name: "Becky Robran",
                                                    address: "12342 Main Street",
                                                    city: "Broomfield",
                                                    state: "CO",
                                                    zip: "34533",
                                                    phone_number: "43253424324",
                                                    description: "I will be a good dog parent.")
          @application_1.pets << @dog_2
      end
      it "I visit /favorites and see a list of all pets with an application." do
        visit '/favorites'

        within("p#application-#{@dog_1.id}") do
          expect(page).to_not have_content(@dog.name)
        end
        within("p#application-#{@dog_1.id}") do
          expect(page).to have_content(@dog_1.name)
        end
        within("p#application-#{@dog_2.id}") do
          expect(page).to have_content(@dog_2.name)
        end
        within("p#application-#{@dog_2.id}") do
          expect(page).to_not have_content(@dog.name)
        end
      end
      it 'will see a list of approved applications' do
        visit "/applications/#{@application_2.id}"

        click_on("Approve Application for #{@dog.name}")

        visit "/favorites"

        within("p#application_approved-#{@dog.id}") do
          expect(page).to have_content(@dog.name)
        end
      end
  end
end
