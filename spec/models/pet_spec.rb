require 'rails_helper'

describe Pet, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should_not allow_value("Pikachu 123").for(:name) }

    it {should validate_presence_of :description}
    it {should validate_presence_of :approximate_age}
    it {should validate_presence_of :image_url}

    it {should validate_presence_of :sex}
    it {should_not allow_value("11").for(:sex) }
    it {should_not allow_value("Male").for(:sex) }
    it {should allow_value("f").for(:sex) }

    it {should validate_presence_of(:name).with_message("can't be blank")}
    it {should validate_presence_of(:name).with_message("is required and must only contain letters")}
    it {should validate_presence_of(:approximate_age).with_message("can't be blank")}
    it {should validate_presence_of(:approximate_age).with_message("must be a number")}
    it {should validate_presence_of(:description).with_message("can't be blank")}
    it {should validate_presence_of(:sex).with_message("can't be blank")}
    it {should validate_presence_of(:image_url).with_message("can't be blank")}
end
  describe 'relationships' do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe 'methods' do
    
  end
end
