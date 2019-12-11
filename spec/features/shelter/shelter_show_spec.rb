require 'rails_helper'

RSpec.describe 'Shelter show page', type: :feature do
  describe 'As a visitor' do
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
                                       description: 'I am a neutered male, white Terrier Mix who loves to play fetch.'
                                       )

    end

    it 'can see links at top of page that go to pet and shelter indexes' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('All Pets', href: '/pets')
      expect(page).to have_link('All Shelters', href: '/shelters')

    end

    it 'can see that shelter with that id including its information' do

      visit "/shelters/#{@shelter_1.id}"
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.zip_code)

    end

    it 'can see the total number of adoptable pets at that shelter, a list of them, and their attributes' do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("#{@shelter_1.name} is currently housing #{@shelter_1.count_pets} pets.")

      expect(page).to have_link('Adoptable Pets', href:"/shelters/#{@shelter_1.id}/pets")

      click_on('Adoptable Pets')
      expect(current_path).to eq "/shelters/#{@shelter_1.id}/pets"
    end

    it 'can see a shelters review rating ave' do
      review_1 = @shelter_1.reviews.create!(title: 'Denver Pet Adoption Process',
                                 rating: 2,
                                 content: 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.',
                                 image_url: "https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg")
      review_2 = @shelter_1.reviews.create!(title: 'Denver Pet Is the Best',
                                rating: 5,
                                content: 'Denver Pet Shelter helped us find a new family member. I can never thank them enough.')

      visit "/shelters/#{@shelter_1.id}"
      expect(page).to have_content("#{@shelter_1.name} has an average review rating of #{@shelter_1.review_ave}%.")
    end

    it 'can see the number of applications on file for that shelter' do
      application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                                 address: "12342 Main Street",
                                                 city: "Broomfield",
                                                 state: "CO",
                                                 zip: "34533",
                                                 phone_number: "43253424324",
                                                 description: "I will be a good dog parent.")
     dog_2 = @shelter_1.pets.create!(image_url: '/',
                        name: 'Kuma',
                        description: 'I am an energetic, black Shiba Inu.',
                        approximate_age: 1,
                        sex: 'F',
                        favorite_status: false)

      application_2 = dog_2.applications.create!(name: "Linda Le",
                                                 address: "12342 Main Street",
                                                 city: "Broomfield",
                                                 state: "CO",
                                                 zip: "34533",
                                                 phone_number: "43253424324",
                                                 description: "I will be a good dog parent.")
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("#{@shelter_1.name} has #{@shelter_1.application_count} applications on file.")
    end
  end
end
