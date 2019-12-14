require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  describe "when I approve an application for one pet" do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')

      @dog_1 = @shelter_1.pets.create!(image_url: '/',
                         name: 'Tofu',
                         approximate_age: 4,
                         sex: 'M',
                         description: 'I am a neutered male, white Terrier Mix who loves to play fetch.'
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
    @application_1.pets << @dog_2

    end

   xit "the other pet on the application is also not approved" do
      visit "/applications/#{@application_1.id}"
      click_on("Approve Application for #{@dog_1.name}")
      expect(current_path).to eql("/pets/#{@dog_1.id}")
      expect(@dog_1.is_adoptable).to eql(false)

      expect(page).to have_content("Status: Adoption Pending")
      expect(page).to have_content("On hold for Becky Robran")

      visit "/pets/#{@dog_2.id}"
      expect(@dog_2.is_adoptable).to eql(true)
      expect(page).to have_content("Status: Adoptable")
      expect(page).to_not have_content("On hold for Becky Robran")

    end
  end
end
