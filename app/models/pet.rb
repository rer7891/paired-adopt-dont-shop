class Pet < ApplicationRecord
  belongs_to :shelter

  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates :shelter, presence: true
  validates :image_url, presence: true
  validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/ }
  validates :description, presence: true
  validates :sex, presence: true
  validates_inclusion_of :sex, in: %w( m f M F)
  validates :approximate_age, presence: true, numericality: { only_integer: true }
  before_save :upcase_field

  def upcase_field
    sex.upcase
  end

  def update_status
    if !is_adoptable
      is_adoptable = true
    else
      is_adoptable = false
    end
  end

end
