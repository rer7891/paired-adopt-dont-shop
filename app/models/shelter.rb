class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_associated :pets
  validates_associated :reviews
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, :length => { :is => 5 }

  def count_pets
    pets.length
  end

end
