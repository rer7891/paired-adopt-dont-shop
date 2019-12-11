require 'rails_helper'

describe Shelter, type: :model do
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
                                     description: 'I am a neutered male, white Terrier Mix who loves to play fetch.',
                                     is_adoptable: false
                                     )
    @application_1 = @dog_1.applications.create!(name: "Becky Robran",
                                              address: "12342 Main Street",
                                              city: "Broomfield",
                                              state: "CO",
                                              zip: "34533",
                                              phone_number: "43253424324",
                                              description: "I will be a good dog parent.")
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}

    it {should validate_presence_of :zip_code}
    it {should_not allow_value("80").for(:zip_code) }

    it {should validate_presence_of(:name).with_message("can't be blank")}
    it {should validate_presence_of(:address).with_message("can't be blank")}
    it {should validate_presence_of(:city).with_message("can't be blank")}
    it {should validate_presence_of(:state).with_message("can't be blank")}
    it {should validate_presence_of(:zip_code).with_message("is not valid - please enter a 5 digit zip code")}
  end

  describe 'relationships' do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe 'methods'do
  it ".count_pets will count how many pets are at that shelter" do
    expect(@shelter_1.count_pets).to eq 1
  end

  it "Does shelter have pets that have an application" do
    expect(@shelter_1.adoptable_pets?).to eql(true)
  end

  it 'should calculate a shelters ave review rating' do
      review_1 = @shelter_1.reviews.create!(title: 'Denver Pet Adoption Process',
                                 rating: 2,
                                 content: 'Denver Pets Shelter makes the process of adopting a pet easy and stress free.',
                                 image_url: "https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg"
                                 )
      review_2 = @shelter_1.reviews.create!(title: 'Denver Pet Is the Best',
                                rating: 5,
                                content: 'Denver Pet Shelter helped us find a new family member. I can never thank them enough.'
                                )
      expect(@shelter_1.review_ave).to eq(3.5)
  end

  it 'should calculate the number of applications on file for that shelter' do
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
    expect(@shelter_1.application_count).to eql(2)
    end
  end
end
