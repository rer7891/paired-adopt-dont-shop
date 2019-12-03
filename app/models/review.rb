class Review < ApplicationRecord
  belongs_to :shelter

  validates :shelter, presence: true
  validates :title, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
  validates :content, presence: true
end
