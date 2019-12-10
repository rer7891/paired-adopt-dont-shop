require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'After visiting a shelters show page and clicking on delete that shelter' do
    before :each do

      @shelter_1 = Shelter.create(name: 'Denver Animal Shelter',
                                     address: '123 Colfax Ave',
                                     city: 'Denver',
                                     state: 'CO',
                                     zip_code: '80004')
      @dog_1 = @shelter_1.pets.create!(image_url: '/',
                        name: 'Tofu',
                        approximate_age: 4,
                        sex: 'M',
                        description: 'I am a neutered male, white Terrier Mix who loves to play fetch.')
      @review_1 = Review.create!(title: 'Denver Pet Adoption Process',
                                  rating: 4,
                                  content: 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.',
                                  image_url: 'https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg',
                                  shelter: @shelter_1)
      @application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                                 address: "12342 Main Street",
                                                 city: "Broomfield",
                                                 state: "CO",
                                                 zip: "34533",
                                                 phone_number: "43253424324",
                                                 description: "I will be a good dog parent.")

    end

    it 'can delete an existing shelter' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Delete This Shelter')
      click_link 'Delete This Shelter'

      expect(current_path).to eq "/shelters"

      expect(page).to_not have_content(@shelter_1.name)

      expect(Review.count).to eql(0)
      expect(Pet.count).to eq(0)
    end
    it "if a shelter has pets with an adoption status pending it cannot delete shelter" do

      visit "/applications/#{@application_1.id}"
      click_on("Approve Application for #{@dog_1.name}")

      visit "/shelters/#{@shelter_1.id}"
      click_link 'Delete This Shelter'

      expect(current_path).to eql("/shelters/#{@shelter_1.id}")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content("This shelter has pets with adoptions pending. You cannot delete it at this moment.")
    end
  end
end
