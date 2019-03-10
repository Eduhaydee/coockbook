class RecipeType < ApplicationRecord
  has_many :recipe
  validates :name, presence: true
end
