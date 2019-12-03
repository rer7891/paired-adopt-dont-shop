require 'rails_helper'

RSpec.describe 'Navigation bar', type: :feature do
  describe 'As a visitor' do
    it 'can see a favorites link' do
      visit '/'
      within 'nav' do
      expect(page).to have_link('My Favorites')
      end
    end
  end
end
