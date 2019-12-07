require 'rails_helper'

describe Favorite do
  describe 'methods'do
    it " can call .favorite_count to find a total number of favorites" do
      shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')
      dog_1 = shelter_1.pets.create!(image_url: '/',
                                       name: 'Tofu',
                                       approximate_age: 4,
                                       sex: 'M',
                                       description: 'I am a neutered male, white Terrier Mix who loves to play fetch.'
                                       )
      dog = shelter_1.pets.create!(image_url: '/',
                                      name: 'Sammy',
                                      approximate_age: 2,
                                      sex: 'F',
                                      description: 'I am a neutered male, white Terrier Mix who loves to play fetch.')
      favorites = Favorite.new({"#{dog_1.id}" => 1, "#{dog.id}" => 1})

      expect(favorites.favorite_count).to eq 2
      expect(favorites.content).to eql({"#{dog_1.id}" => 1, "#{dog.id}" => 1})
    end

    it "can add a pet to favorites" do
      shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')
      dog_1 = shelter_1.pets.create!(image_url: '/',
                                       name: 'Tofu',
                                       approximate_age: 4,
                                       sex: 'M',
                                       description: 'I am a neutered male, white Terrier Mix who loves to play fetch.'
                                       )
      dog = shelter_1.pets.create!(image_url: '/',
                                      name: 'Sammy',
                                      approximate_age: 2,
                                      sex: 'F',
                                      description: 'I am a neutered male, white Terrier Mix who loves to play fetch.')

      favorites = Favorite.new({"#{dog_1.id}" => 1})

      expect(favorites.content.key?("#{dog.id}")).to eql(false)
      favorites.add_favorite("#{dog.id}")
      expect(favorites.content.key?("#{dog.id}")).to eql(true)

      favorites.favorite_delete([dog_1, dog])
      expect(favorites.content).to eql({})

      favorites.add_favorite("#{dog_1.id}")
      expect(favorites.keys).to eql([dog_1.id.to_s])
      expect(favorites.include?("#{dog_1.id}")).to eql(true)
      expect(favorites.include?("#{dog.id}")).to eql(false)
    end
  end
end
