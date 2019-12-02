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
                                     description: 'I am a neutered male, white Terrier Mix who loves to play fetch.'
                                     )
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}

    it {should validate_presence_of :zip_code}
    it { should validate_length_of(:zip_code).is_equal_to(5) }
    it {should_not allow_value("80").for(:zip_code) }
  end

  describe 'relationships' do
    it {should have_many :pets}
  end

  describe 'methods'do
  it ".count_pets" do
    expect(@shelter_1.count_pets).to eq 1
  end

  describe 'test' do
    it 'test' do
      @dog_1.update({"image_url"=>"https://media.wired.com/photos/5dd593a829b9c40008b179b3/
        master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg", "name"=>"Baby Yoda", "description"=>"I
        am an adorable one strong with the Force. Enjoys eating frogs.", "approximate_age"=>"500", "sex"=>"M", "id"=>"1"})
      @dog_1.save
    end
  end
end
end
