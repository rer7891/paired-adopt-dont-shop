require 'rails_helper'

RSpec.describe "As a visitor ", type: :feature do
  describe "when I visit /applications/:id" do
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
        @application_1.pets << @dog_2

        @application_2 = @dog_1.applications.create!(name: "Linda Le",
                                                   address: "12342 Main Street",
                                                   city: "Broomfield",
                                                   state: "CO",
                                                   zip: "34533",
                                                   phone_number: "43253424324",
                                                   description: "I will be a good dog parent.")
          @application_2.pets << @dog_1
    end

    it "I can see all application details including all pets" do

      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.phone_number)
      expect(page).to have_content(@application_1.description)

      expect(page).to have_content(@dog_1.name)
      expect(page).to have_content(@dog_2.name)
      expect(page).to_not have_content(@dog.name)
    end

    it 'can approve an application for that specific pet' do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_link("Approve Application for #{@dog_1.name}")
      expect(page).to have_link("Approve Application for #{@dog_2.name}")

      click_on("Approve Application for #{@dog_1.name}")
      expect(current_path).to eql("/pets/#{@dog_1.id}")


      expect("#{@dog_1.is_adoptable}").to eql("true")
      expect(page).to have_content("Status: Adoption Pending")
      expect(page).to have_content("On hold for Becky Robran")
      expect(page).to_not have_content("Linda Le")

    end

    it "cannot see a link to approve an application and see link to unapprove after an application for that pet is approved" do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_link("Approve Application for #{@dog_1.name}")
      expect(page).to have_link("Approve Application for #{@dog_2.name}")

      click_on("Approve Application for #{@dog_1.name}")

      expect(page).to_not have_link("Approve Application for #{@dog_1.name}")
      expect(page).to_not have_link("Approve Application for #{@dog_2.name}")
      expect(page).to have_link("Revoke Approved Application for #{@dog_1.name}")
      expect(page).to have_link("Revoke Approved Application for #{@dog_2.name}")
    end

    it "can revoke approval of an application for a specific pet" do

      visit "/applications/#{@application_1.id}"

      click_on("Approve Application for #{@dog_1.name}")

      visit "/applications/#{@application_1.id}"

      expect(page).to have_link("Revoke Approved Application for #{@dog_1.name}")
      click_on ("Revoke Approved Application for #{@dog_1.name}")

      expect(current_path).to eql("/applications/#{@application_1.id}")
      expect(page).to have_link("Approve Application for #{@dog_1.name}")

      visit "/pets/#{@dog_1.id}"
      expect(page).to have_content("Status: Adoption Pending")

    end
  end 
end
