require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :application}
  end
describe 'methods' do
  it "can update an application's approval status" do

      shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')


      dog_1 = shelter_1.pets.create!(image_url: '/',
                                       name: 'Tofu',
                                       approximate_age: 4,
                                       sex: 'M',
                                       description: 'I am a neutered male, white Terrier Mix who loves to play fetch.',
                                       is_adoptable: false
                                       )

     dog_2 = shelter_1.pets.create!(image_url: '/',
                                      name: 'Butter',
                                      approximate_age: 4,
                                      sex: 'F',
                                      description: 'I am a happy, loving Golden Retriever.',
                                      is_adoptable: true
                                      )

       application_1 = dog_1.applications.create!(name: "Becky Robran",
                                                address: "12342 Main Street",
                                                city: "Broomfield",
                                                state: "CO",
                                                zip: "34533",
                                                phone_number: "43253424324",
                                                description: "I will be a good dog parent.")

        application_2 = dog_1.applications.create!(name: "Linda Le",
                                                  address: "12342 Union Dr",
                                                  city: "Broomfield",
                                                  state: "CO",
                                                  zip: "12345",
                                                  phone_number: "1234567890",
                                                  description: "I love dogs.")

    pet_application_1 = PetApplication.where(pet_id: dog_1.id, application_id: application_2.id).first
    expect(pet_application_1.update_approval_status).to eql(true)
  end
  end
end
