class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews, :dependent => :delete_all

  validates_associated :pets
  validates_associated :reviews
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, :length => { :is => 5, message: "is not valid - please enter a 5 digit zip code"}

  def count_pets
    pets.length
  end

  def adoptable_pets?
    pets.where(is_adoptable: false).any?
  end

  def review_ave
    reviews.average(:rating)
  end

  def application_count
    pets.joins(:applications).select(:application_id).distinct.count
  end
end
