require 'rails_helper'

RSpec.describe 'Pets show page', type: :feature do
  describe 'As a visitor' do
    before :each do

      @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter',
                                 address: '123 Colfax Ave',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip_code: '80004')

      @dog_1 = @shelter_1.pets.create!(image_url: '/',
                         name: 'Tofu',
                         description: 'I am a neutered male, white Terrier Mix who loves to play fetch.',
                         approximate_age: 4,
                         sex: 'M',
                         )
      end

    it 'can see links to the pets and shelters index pages' do

      visit "pets/#{@dog_1.id}"

      expect(page).to have_link('All Pets', href: '/pets')
      expect(page).to have_link('All Shelters', href: '/shelters')

    end

    it 'can see links to edit and delete that pet' do

      visit "pets/#{@dog_1.id}"

      expect(page).to have_link('Edit Pet', href: "/pets/#{@dog_1.id}/edit")
      expect(page).to have_link('Delete Pet', href: "/pets/#{@dog_1.id}")

    end

    it 'can see the pet with that id, its attributes, and adoption status'  do

      visit "pets/#{@dog_1.id}"

      expect(page).to have_xpath("//img[@src='#{@dog_1.image_url}']")
      expect(page).to have_content(@dog_1.name)
      expect(page).to have_content(@dog_1.description)
      expect(page).to have_content(@dog_1.approximate_age)
      expect(page).to have_content(@dog_1.sex)
      expect(page).to have_content("Adoptable")

    end
  end
end
