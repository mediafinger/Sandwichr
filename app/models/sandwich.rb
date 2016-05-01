class Sandwich < ActiveRecord::Base
  has_many :sandwich_ingredients
  has_many :ingredients, through: :sandwich_ingredients

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
end
