require 'rails_helper'

describe Pet, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should_not allow_value("Pikachu 123").for(:name) }

    it {should validate_presence_of :description}

    it {should validate_presence_of :image_url}

    it {should validate_presence_of :sex}
    it {should_not allow_value("11").for(:sex) }
    it {should_not allow_value("Male").for(:sex) }
    it {should allow_value("f").for(:sex) }


    it {should validate_presence_of :approximate_age}
    it {should validate_numericality_of(:approximate_age)}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end

end
